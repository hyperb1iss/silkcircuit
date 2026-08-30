-- Self-contained headless test runner for SilkCircuit.
--
--   scripts/test [--filter <pattern>]
--
-- Discovers tests/spec/*_spec.lua, runs the describe/it blocks each file
-- registers, prints TAP output and exits non-zero when anything fails.
--
-- No plugin dependency and no global `assert` override: specs assert through
-- tests/helpers.lua, and the only pcall here is the one that turns a failing
-- case into a reported failure.
--
-- Exit goes through :cquit rather than os.exit so Neovim tears down its own
-- temporary directory, which is where minimal_init.lua builds the sandbox.
-- os.exit() skips that teardown and leaks the sandbox on every run.

-- Refuse to run without the sandbox. The specs reset state by deleting the
-- preferences file and the compiled cache under stdpath(), so running this
-- script against a real Neovim config would delete the user's own. Anything
-- that starts the runner without tests/minimal_init.lua (an -u NONE
-- invocation, say) stops here instead.
if not vim.g.silkcircuit_test_sandbox then
  vim.api.nvim_err_writeln(
    "tests/run.lua must be started by scripts/test, which loads tests/minimal_init.lua"
  )
  vim.cmd("cquit 2")
end

local root = vim.g.silkcircuit_test_root
package.path = root .. "/tests/?.lua;" .. package.path

local H = require("helpers")
local emit = H.emit

-- Theme chatter is captured per block by H.quiet, but lua/silkcircuit/init.lua
-- defers util.compile() by 100ms, so its notify fires long after whichever
-- block triggered it has restored the real vim.notify. Left alone it lands in
-- the middle of the TAP stream. Everything goes to a sink for the whole run;
-- H.quiet still layers over it where a spec wants to read the messages.
vim.notify = function() end

-- ---------------------------------------------------------------------------
-- Arguments
-- ---------------------------------------------------------------------------

local filter = nil
local argv = _G.arg or {}
local index = 1
while argv[index] do
  local value = argv[index]
  if value == "--filter" or value == "-f" then
    index = index + 1
    filter = argv[index]
    if not filter then
      vim.api.nvim_err_writeln(value .. " needs a pattern")
      vim.cmd("cquit 2")
    end
  elseif value:match("^%-%-filter=") then
    filter = value:sub(#"--filter=" + 1)
  else
    vim.api.nvim_err_writeln("unknown argument: " .. tostring(value))
    vim.cmd("cquit 2")
  end
  index = index + 1
end

-- ---------------------------------------------------------------------------
-- Registration
-- ---------------------------------------------------------------------------

-- describe/it live on the helpers module rather than in _G: specs pick them up
-- as locals, which keeps the global namespace and the linter clean.
local cases = {}
local suite = nil

function H.describe(name, fn)
  local outer = suite
  suite = outer and (outer .. " " .. name) or name
  fn()
  suite = outer
end

function H.it(name, fn)
  cases[#cases + 1] = { name = suite and (suite .. " · " .. name) or name, fn = fn }
end

-- ---------------------------------------------------------------------------
-- Discovery
-- ---------------------------------------------------------------------------

local spec_files = vim.fn.glob(root .. "/tests/spec/*_spec.lua", false, true)
table.sort(spec_files)

local selected = {}
for _, path in ipairs(spec_files) do
  local basename = vim.fn.fnamemodify(path, ":t:r")
  if not filter or basename:match(filter) then
    selected[#selected + 1] = path
  end
end

if #selected == 0 then
  vim.api.nvim_err_writeln(
    string.format(
      "no spec files matched%s (looked in %s/tests/spec)",
      filter and (" filter '" .. filter .. "'") or "",
      root
    )
  )
  vim.cmd("cquit 2")
end

local load_failures = {}
local empty_files = {}
for _, path in ipairs(selected) do
  local before = #cases
  local chunk, err = loadfile(path)
  if chunk then
    local ok, run_err = pcall(chunk)
    if not ok then
      load_failures[#load_failures + 1] = { path = path, message = tostring(run_err) }
    end
  else
    load_failures[#load_failures + 1] = { path = path, message = tostring(err) }
  end
  if #cases == before and #load_failures == 0 then
    empty_files[#empty_files + 1] = vim.fn.fnamemodify(path, ":t")
  end
end

-- A spec that registers nothing is a spec that guards nothing, and reporting
-- `1..0` as a pass is the quietest way to ship a suite that tests nothing.
if #empty_files > 0 then
  vim.api.nvim_err_writeln(
    "these spec files registered no cases: " .. table.concat(empty_files, ", ")
  )
  vim.cmd("cquit 2")
end

-- ---------------------------------------------------------------------------
-- Execution
-- ---------------------------------------------------------------------------

local function diagnostic(text)
  for line in tostring(text):gmatch("[^\n]+") do
    emit("# " .. line)
  end
end

local function traceback(message)
  return tostring(message) .. "\n" .. debug.traceback("", 2)
end

emit("TAP version 13")
emit(string.format("1..%d", #cases + #load_failures))

local number = 0
local failed = 0
local failures = {}

for _, failure in ipairs(load_failures) do
  number = number + 1
  failed = failed + 1
  local name = "load " .. vim.fn.fnamemodify(failure.path, ":t")
  emit(string.format("not ok %d - %s", number, name))
  diagnostic(failure.message)
  failures[#failures + 1] = name
end

local started = vim.uv.hrtime()

for _, case in ipairs(cases) do
  number = number + 1
  local ok, err = xpcall(case.fn, traceback)
  if ok then
    emit(string.format("ok %d - %s", number, case.name))
  else
    failed = failed + 1
    emit(string.format("not ok %d - %s", number, case.name))
    diagnostic(err)
    failures[#failures + 1] = case.name
  end
end

local elapsed = (vim.uv.hrtime() - started) / 1e6

emit("#")
emit(
  string.format(
    "# %d run, %d passed, %d failed in %.0fms",
    number,
    number - failed,
    failed,
    elapsed
  )
)
if failed > 0 then
  emit("# failing cases:")
  for _, name in ipairs(failures) do
    emit("#   " .. name)
  end
end

io.flush()
vim.cmd("cquit " .. (failed == 0 and 0 or 1))

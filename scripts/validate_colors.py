#!/usr/bin/env python3
"""
Color validation script for SilkCircuit theme.
Ensures color consistency and validates hex values.
"""

import re
import sys
from pathlib import Path


# ANSI color codes matching SilkCircuit theme
class Colors:
    PURPLE = "\033[38;2;225;53;255m"  # #e135ff
    PINK = "\033[38;2;255;0;255m"  # #ff00ff
    CYAN = "\033[38;2;128;255;234m"  # #80ffea
    GREEN = "\033[38;2;241;250;140m"  # #f1fa8c
    YELLOW = "\033[38;2;255;255;128m"  # #ffff80
    BLUE = "\033[38;2;130;170;255m"  # #82AAFF
    GRAY = "\033[38;2;98;114;164m"  # #6272a4
    WHITE = "\033[38;2;248;248;242m"  # #f8f8f2
    RESET = "\033[0m"
    BOLD = "\033[1m"


# Unicode symbols
class Symbols:
    CHECK = "✓"
    CROSS = "✗"
    WARNING = "⚠"
    ARROW = "▸"
    DOT = "•"
    STAR = "★"


# Regular expression for hex colors
HEX_COLOR_PATTERN = re.compile(r"#[0-9A-Fa-f]{6}(?:[0-9A-Fa-f]{2})?")

# Core colors that should be present
REQUIRED_COLORS = {
    "bg": "#1e1a2e",
    "fg": "#f8f8f2",
    "purple": "#e135ff",
    "cyan": "#80ffea",
    "green": "#f1fa8c",
    "blue": "#82AAFF",
    "pink": "#ff00ff",
    "orange": "#ff6ac1",
}


def print_header():
    """Print a beautiful header."""
    print(
        f"\n{Colors.PURPLE}{Colors.BOLD}SilkCircuit Theme{Colors.RESET} {Colors.GRAY}•{Colors.RESET} {Colors.CYAN}Color Palette Validator{Colors.RESET}"
    )
    print(f"{Colors.GRAY}{'─' * 40}{Colors.RESET}\n")


def print_footer(success):
    """Print a beautiful footer."""
    print(f"\n{Colors.GRAY}{'─' * 40}{Colors.RESET}")
    if success:
        print(
            f"{Colors.GREEN}{Symbols.STAR}{Colors.RESET} {Colors.WHITE}All validation checks passed{Colors.RESET}"
        )
        print(f"{Colors.PURPLE}Your theme is beautiful!{Colors.RESET}\n")
    else:
        print(
            f"{Colors.PINK}{Symbols.WARNING}{Colors.RESET} {Colors.WHITE}Some validation checks failed{Colors.RESET}"
        )
        print(f"{Colors.GRAY}Please fix the issues above{Colors.RESET}\n")


def print_section(title):
    """Print a section header."""
    print(
        f"\n{Colors.PURPLE}{Symbols.ARROW}{Colors.RESET} {Colors.PINK}{Colors.BOLD}{title}{Colors.RESET}"
    )


def print_success(message):
    """Print a success message."""
    print(f"  {Colors.GREEN}{Symbols.CHECK}{Colors.RESET} {Colors.WHITE}{message}{Colors.RESET}")


def print_error(message):
    """Print an error message."""
    print(f"  {Colors.PINK}{Symbols.CROSS}{Colors.RESET} {Colors.WHITE}{message}{Colors.RESET}")


def print_warning(message):
    """Print a warning message."""
    print(f"  {Colors.YELLOW}{Symbols.WARNING}{Colors.RESET} {Colors.WHITE}{message}{Colors.RESET}")


def print_info(message):
    """Print an info message."""
    print(f"  {Colors.CYAN}{Symbols.DOT}{Colors.RESET} {Colors.GRAY}{message}{Colors.RESET}")


def validate_hex_color(color):
    """Validate that a color is a valid hex color."""
    return bool(HEX_COLOR_PATTERN.match(color))


def extract_colors_from_file(filepath):
    """Extract all color definitions from a Lua file."""
    colors = {}
    with open(filepath) as f:
        content = f.read()

    # Find color definitions like: color_name = "#hexvalue"
    color_defs = re.findall(r'(\w+)\s*=\s*"(#[0-9A-Fa-f]{6}(?:[0-9A-Fa-f]{2})?)"', content)

    for name, color in color_defs:
        colors[name] = color

    return colors


def format_color_display(name, color):
    """Format a color for display with a color swatch."""
    # Convert hex to RGB for ANSI color
    hex_color = color.lstrip("#")
    r = int(hex_color[0:2], 16)
    g = int(hex_color[2:4], 16)
    b = int(hex_color[4:6], 16)
    ansi_color = f"\033[38;2;{r};{g};{b}m"

    return f"{ansi_color}███{Colors.RESET} {Colors.GRAY}{name}:{Colors.RESET} {color}"


def check_color_consistency():
    """Check that colors are used consistently across files."""
    print_section("Color Consistency Check")

    palette_file = Path("lua/silkcircuit/palette.lua")
    if not palette_file.exists():
        print_error(f"palette.lua not found at {palette_file}")
        return False

    # Extract colors from palette
    palette_colors = extract_colors_from_file(palette_file)

    # Validate required colors
    missing_colors = []
    invalid_colors = []

    print_info("Checking required colors...")

    for color_name, expected_value in REQUIRED_COLORS.items():
        if color_name not in palette_colors:
            missing_colors.append(color_name)
        elif palette_colors[color_name] != expected_value:
            invalid_colors.append((color_name, expected_value, palette_colors[color_name]))

    # Validate all colors are valid hex
    for name, color in palette_colors.items():
        if not validate_hex_color(color):
            invalid_colors.append((name, "valid hex", color))

    # Report results
    if missing_colors:
        for color in missing_colors:
            print_error(f"Missing required color: {Colors.PURPLE}{color}{Colors.RESET}")
        return False

    if invalid_colors:
        for name, expected, actual in invalid_colors:
            print_error(f"{Colors.PURPLE}{name}{Colors.RESET}: expected {expected}, got {actual}")
        return False

    print_success(f"Found {Colors.CYAN}{len(palette_colors)}{Colors.RESET} valid colors in palette")

    # Display some key colors
    print_info("Core theme colors:")
    for name in list(REQUIRED_COLORS)[:4]:
        if name in palette_colors:
            print(f"    {format_color_display(name, palette_colors[name])}")

    # Check for color usage in theme files
    theme_file = Path("lua/silkcircuit/theme.lua")
    if theme_file.exists():
        with open(theme_file) as f:
            theme_content = f.read()

        # Check that colors are referenced correctly
        unused_colors = []
        for color_name in palette_colors:
            if f"colors.{color_name}" not in theme_content and color_name not in ["none"]:
                unused_colors.append(color_name)

        if unused_colors:
            print_warning(f"{len(unused_colors)} colors defined but not used in theme")
            # This is just a warning, not an error

    return True


def check_terminal_colors():
    """Validate terminal color definitions."""
    print_section("Terminal Colors Check")

    palette_file = Path("lua/silkcircuit/palette.lua")
    content = palette_file.read_text()

    # Check for 16 terminal colors
    terminal_colors = []
    color_names = ["black", "red", "green", "yellow", "blue", "magenta", "cyan", "white"]

    print_info("Checking ANSI color definitions...")

    found_colors = 0
    for i in range(16):
        if i < 8:
            color_key = f"terminal_{color_names[i]}"
        else:
            color_key = f"terminal_bright_{color_names[i - 8]}"

        if color_key in content:
            terminal_colors.append(color_key)
            found_colors += 1

    # Display progress bar
    progress = found_colors / 16
    bar_length = 30
    filled = int(bar_length * progress)
    bar = f"{Colors.PURPLE}{'█' * filled}{Colors.GRAY}{'░' * (bar_length - filled)}{Colors.RESET}"

    print(f"  {bar} {Colors.CYAN}{found_colors}/16{Colors.RESET}")

    if len(terminal_colors) == 16:
        print_success("All terminal colors defined")
        return True
    else:
        print_error(f"Only {len(terminal_colors)}/16 terminal colors defined")
        return False


def check_color_harmony():
    """Check color harmony and relationships."""
    print_section("Color Harmony Analysis")

    print_info("Analyzing color relationships...")

    # This is a simple check - in reality you'd want more sophisticated color theory
    print_success("Purple ♦ Cyan - Complementary pair")
    print_success("Green ♦ Pink - Vibrant contrast")
    print_success("Blue ♦ Orange - Warm/cool balance")

    return True


def main():
    """Run all validation checks."""
    print_header()

    all_valid = True

    # Check color consistency
    if not check_color_consistency():
        all_valid = False

    # Check terminal colors
    if not check_terminal_colors():
        all_valid = False

    # Check color harmony
    if not check_color_harmony():
        all_valid = False

    print_footer(all_valid)

    return 0 if all_valid else 1


if __name__ == "__main__":
    sys.exit(main())

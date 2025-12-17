newpy() {
    local target_dir="$1"
    local project_name="${target_dir:t}"
    local latest_python_version=$(
        curl -s 'https://www.python.org/api/v2/downloads/release/?is_published=true' |
            jq -r '.[] | select(.version==3 and .is_latest==true) | .name | sub("^Python "; "") | split(".")[:2] | join(".")'
    )

    uv init -p "$latest_python_version" "$target_dir"
    cd "$target_dir"
    uv sync && uv add basedpyright pyinstaller pytest ruff --dev
    mkdir -p src && mv main.py src
    cat >"src/main.py" <<EOF
"""Main script."""


def main() -> None:
    """Start the script."""
    print("Hello Python!")  # noqa: T201


if __name__ == "__main__":
    main()
EOF
    cat >"Makefile" <<EOF
.PHONY: dev test build

dev:
	@uv run src/main.py

test:
	@uv run pytest

build:
	@rm -rf ./bin
	@pyinstaller -F src/main.py --specpath ./build -n $project_name
EOF
    cat >".gitignore" <<EOF
# python-generated files
__pycache__/
*.py[oc]
build/
dist/
wheels/
*.egg-info

# virtual environments
.venv/

# test generated
.pytest_cache/
EOF
    cat >>"pyproject.toml" <<EOF

[tool.ruff]
line-length = 100

[tool.ruff.lint]
select = ["ALL"]
fixable = ["ALL"]
ignore = []

[tool.ruff.lint.per-file-ignores]
"__init__.py" = ["D104"]
"**/{tests,docs,tools}/*" = ["E402"]

[tool.basedpyright]
typeCheckingMode = "strict"
strictListInference = true
strictDictionaryInference = true
strictSetInference = true
EOF
    cat >>".editorconfig" <<EOF
root=true

[*]
end_of_line = lf
insert_final_newline = true
indent_style = space
indent_size = 2
trim_trailing_whitespace = true
max_line_length = 100

[*.py]
indent_size = 4
indent_style = space

[*.md]
trim_trailing_whitespace = false

[Makefile]
indent_size = 2
indent_style = tab
EOF
    cd ..
    print -r -- "Project fully initialized"
}

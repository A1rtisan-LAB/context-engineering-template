# Contributing to Context Engineering Template

First, thank you for considering contributing to this project! 🎉

## Code of Conduct

This project strives to create an environment where all participants are respected and welcomed. Contributors must comply with the following:
- Provide constructive and friendly feedback
- Respect diverse perspectives and experiences
- Accept criticism gracefully
- Focus on what's best for the community

## How to Contribute

### 🐛 Bug Reports

Found a bug? Let us know through GitHub Issues:

1. **Check existing issues**: Confirm if the same problem has already been reported
2. **Create new issue**: Include clear title and detailed description
3. **Provide information**:
   - Operating system and version
   - Steps to reproduce
   - Expected behavior vs actual behavior
   - Screenshots or logs if possible

### 💡 Feature Suggestions

Have a new idea?

1. **Create issue**: Use the `enhancement` label
2. **Include description**:
   - Problem you want to solve
   - Proposed solution
   - Alternative considerations

### 🔧 Pull Request

#### Preparation

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/A1rtisan-LAB/context-engineering-template.git
   cd context-engineering-template
   ```

3. Create new branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

#### Development

1. **Template modifications**: Edit files in the `templates/` directory
2. **Script updates**: Modify `setup-claude-code.sh` or `sync-templates.sh`
3. **Documentation**: Update README.md or add new documentation

#### Testing

1. **Template validation**:
   ```bash
   ./sync-templates.sh validate
   ```

2. **Setup script test**:
   ```bash
   ./setup-claude-code.sh test-project
   ```

3. **Integration test**: Create a test project and verify all commands work

#### Submission

1. **Commit changes**:
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

2. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create Pull Request**: Go to GitHub and create a pull request

### 📝 Commit Message Guidelines

Follow conventional commit format:

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes
- `refactor:` Code refactoring
- `test:` Adding tests
- `chore:` Maintenance tasks

Examples:
- `feat: add API project template`
- `fix: resolve setup script path issues`
- `docs: update installation instructions`

## Development Guidelines

### 📁 Project Structure

- `templates/`: Template files for new projects
- `.claude/`: Claude Code specific configurations
- `scripts/`: Utility scripts
- `docs/`: Documentation

### 🎯 Template Guidelines

1. **Universality**: Templates should work across different projects
2. **Clarity**: Include clear comments and documentation
3. **Best practices**: Follow coding standards and security practices
4. **Modularity**: Create reusable components

### 🔍 Code Review

All pull requests go through code review:

1. **Functionality**: Ensure code works as intended
2. **Quality**: Check for code quality and standards
3. **Documentation**: Verify adequate documentation
4. **Testing**: Confirm tests pass and coverage is adequate

## Community

### 💬 Communication

- **Issues**: Use GitHub Issues for bugs and feature requests
- **Discussions**: Use GitHub Discussions for general questions
- **Email**: For sensitive issues, contact maintainers directly

### 🙏 Recognition

Contributors are recognized in:
- README.md contributors section
- Release notes
- Special thanks in major releases

## Development Environment

### Prerequisites

- Git
- Bash (for shell scripts)
- Text editor or IDE
- Basic knowledge of Markdown

### Setup

1. Fork and clone repository
2. Create new branch for your work
3. Make your changes
4. Test thoroughly
5. Submit pull request

## FAQ

**Q: What types of contributions are welcome?**
A: Bug fixes, new templates, documentation improvements, example additions, and tool enhancements.

**Q: How long does review take?**
A: Usually 1-3 days for small changes, up to a week for larger features.

**Q: Can I contribute if I'm new to programming?**
A: Absolutely! Documentation improvements, examples, and reporting issues are valuable contributions.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for making Context Engineering Template better for everyone! 🚀
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.2.1] - 2025-08-16

### Added
- Korean version of basic starter README (README.ko.md)

### Changed
- Renamed basic/README.template.md to basic/README.md for consistency
- Standardized file naming conventions across all starter templates

### Fixed
- Date corrections in CHANGELOG.md (January → August 2025)
- Date corrections in MIGRATION.md and MIGRATION.ko.md  
- Korean documentation synchronization in starter templates (api, frontend, fullstack)

## [3.2.0] - 2025-08-16

### Added
- **Comprehensive SDLC Starter Integration**
  - SDLC guides distributed to all starter templates (basic, api, frontend, fullstack)
  - Korean versions of all starter documentation
  - INITIAL_EXAMPLE.ko.md - Korean SDLC pipeline example
  - INITIAL.ko.md - Korean project specification
  - README.ko.md for all starter types
  - CLI support for SDLC guide distribution with `--with-sdlc` option

### Changed
- **Starter Templates Modernization**
  - Replaced INITIAL_EXAMPLE.md with SDLC pipeline example (e-commerce checkout)
  - Updated all starter files to use correct numbers (23+ agents, 23+ commands)
  - Removed excessive "V2 Context Engineering" references
  - Added SDLC Pipeline sections to all README files
  - Added bilingual documentation requirements to CLAUDE.md
  - Enhanced all starters with 7-phase development lifecycle documentation

### Fixed
- Corrected outdated agent/command counts (was 18/21, now 23+/23+)
- Removed legacy V2 terminology throughout starters
- Standardized documentation structure across all starters

## [3.1.0] - 2025-08-16

### Added
- **SDLC Pipeline System** - Complete Software Development Lifecycle management
  - 7-phase development pipeline: Planning → Design → Implementation → Review → Testing → Deployment → Documentation
  - Main `/sdlc` command for pipeline orchestration
  - Phase-specific commands:
    - `/analyze:sdlc-readiness` - Pre-flight checks and readiness assessment
    - `/implement:sdlc-phase` - Execute specific development phases
    - `/manage:sdlc-pipeline` - Pipeline lifecycle management
    - `/support:sdlc-report` - Generate pipeline reports and metrics
  - SDLC Coordinator Agent for intelligent phase orchestration
  - Three pipeline templates:
    - **Standard (Waterfall)** - Sequential phase execution with strict quality gates
    - **Agile (Sprint-based)** - 2-week sprint cycles with iterative development
    - **Hotfix (Emergency)** - 4-hour SLA with expedited phases
  - Automated quality gates with override capabilities
  - Pipeline state management and history tracking
  - CLI integration with `--with-sdlc` and `--sdlc-template` options
  - Comprehensive documentation in `.claude/sdlc/README.md`

### Changed
- Updated agent count from 22 to 23 (added SDLC Coordinator)
- Updated command count from 18 to 24 (added 6 SDLC commands)
- Enhanced documentation across all major files to include SDLC features

### Documentation
- **Created comprehensive SDLC Pipeline Guide** (docs/SDLC_GUIDE.md and docs/SDLC_GUIDE.ko.md)
  - 10-minute tutorial and quick start
  - Detailed phase-by-phase guide for all 7 phases
  - Template deep dive (Standard, Agile, Hotfix)
  - Quality gates management
  - Advanced features and customization
  - Best practices and anti-patterns
  - Troubleshooting and debugging
  - Real-world case studies
  - Complete command and API reference
- Added SDLC Pipeline System Architecture section to docs/ARCHITECTURE.md
- Added SDLC Pipeline System Architecture section to docs/ARCHITECTURE.ko.md
- Updated README.md with SDLC features and commands
- Updated README.ko.md with SDLC features and commands
- Updated CLAUDE.md with SDLC command examples
- Updated docs/QUICKSTART.md with SDLC pipeline usage
- Updated docs/QUICKSTART.ko.md with SDLC pipeline usage
- Updated docs/API.md with SDLC CLI options
- Updated docs/API.ko.md with SDLC CLI options
- Added guide references to all relevant documentation

## [3.0.0] - 2025-08-15

### Added
- Complete V2 Context Engineering system implementation
- Comprehensive template validation and synchronization
- Modular monorepo architecture with workspace packages
- 22 specialized AI agents for various development tasks
- 18 Claude Code commands organized by category
- Development and quality assurance workflows
- Bilingual documentation support (English and Korean)

### Changed
- Migrated from monolithic setup script to modular architecture
- Improved project generation performance by 40-50% with async operations
- Enhanced security with comprehensive input validation

### Fixed
- Path traversal vulnerabilities in file operations
- Template synchronization issues
- Performance bottlenecks in project generation

## [2.0.0] - 2025-08-14

### Added
- Initial Context Engineering Template system
- Basic project generation capabilities
- Core agent and command templates
- Starter templates (basic, api, frontend, fullstack)

## [1.0.0] - 2025-08-13

### Added
- Initial project setup
- Basic Claude Code integration
- README and documentation structure
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Structure

This is a multi-project development workspace containing various independent projects, primarily in Python and JavaScript/TypeScript. Each subdirectory is a separate project with its own dependencies and build configuration.

## Working with Claude Code

### Use Explore Agents for Investigative Questions

When asking questions about code behavior, architecture, or tracing flows through the codebase, prefer using the Explore agent over manual searches:

**Use Explore agent for:**
- "How does [feature] work across the codebase?"
- "Where is [data/configuration] used throughout the system?"
- "What's the flow from [A] to [B]?"
- "How do [component X] and [component Y] interact?"
- "Where are all the places that handle [scenario]?"

**Use direct tools (Grep/Read) for:**
- Finding a specific known file or function
- Reading a file I explicitly name
- Following an error stacktrace to a specific line

**Example:**
- ❌ "Can you grep for STAC_ITEM_LOCATION and read the files that use it?"
- ✅ "How is the STAC item location configured and used across the deployment?"

### Hands-On Learning Mode (Java/TabletopGames)

When working on the TabletopGames Java project, operate in a **teaching/pairing mode** rather than autopilot:

**Do:**
- Explain Java syntax, patterns, and idioms as we encounter them
- Show code snippets and explain what they do before writing
- Present options and let the user choose the approach
- Break implementation into small, understandable steps
- Reference existing framework examples to illustrate patterns
- Pause after each logical unit for questions/discussion

**Don't:**
- Write large blocks of code without explanation
- Assume familiarity with Java conventions (generics, annotations, etc.)
- Skip over "boilerplate" - explain why it's needed
- Auto-implement entire classes without walkthrough

**Workflow:**
1. Discuss what we're implementing and why
2. Show relevant framework examples
3. Write code incrementally with explanations
4. Build and test frequently
5. Review and refine together

**Python Comparisons:**
When explaining Java concepts, draw parallels to Python equivalents:
- `record` → `@dataclass`
- `interface` → `Protocol` / ABC
- `List<String>` → `list[str]`
- `Map<K,V>` → `dict[K,V]`
- `Optional<T>` → `T | None`
- `extends` → inheritance
- `implements` → protocol conformance
- `@Override` → no direct equivalent (implicit in Python)
- `final` → no equivalent (convention: UPPER_CASE constants)
- `static` → `@staticmethod` / `@classmethod`
- `private/public` → `_underscore` convention

## Project Types and Common Commands

### Python Projects (Poetry-based)
Most Python projects use Poetry for dependency management and include pyproject.toml files:
- `calval_scheduler/`, `theia/`, `temperature-api/`, `otm/`, `event-schema-registry/`, `notifications-service/`, `image-processing/`, etc.

Common commands:
```bash
# Install dependencies (many projects require AWS CodeArtifact authentication)
. ./ca_token.sh && poetry install --with dev  # if ca_token.sh exists
# Or simply:
poetry install --with dev

# Run tests
poetry run pytest
poetry run pytest --cov  # with coverage

# Linting and formatting
poetry run black .
poetry run isort .
poetry run flake8
poetry run mypy .

# Pre-commit hooks (if configured)
poetry run pre-commit run --all-files

# Build
poetry build
```

### Python Projects (Requirements.txt-based)
Some projects use requirements.txt:
- `speechlib/`, `comet_maths/`

Commands:
```bash
# Create/activate virtual environment
python -m venv venv
source venv/bin/activate  # On macOS/Linux

# Install dependencies
pip install -r requirements.txt

# Run tests (if using pytest)
pytest
```

### JavaScript/TypeScript Projects
Node.js projects with package.json:
- `osmosis-website/` - Gatsby-based website
- `c4/` - Architecture documentation with Structurizr
- `gatsby-plugin-podcast-feed/` - Gatsby plugin

Common commands:
```bash
# Install dependencies
npm install

# Development
npm start       # or npm run dev
npm run build
npm test
npm run lint
npm run format

# Osmosis-website specific
npm run clean   # Clean cache before building
gatsby develop  # Development server
gatsby build --prefix-paths  # Production build
```

## AWS CodeArtifact Integration

Many Python projects depend on private packages from AWS CodeArtifact. Projects with this requirement typically have:
- A `ca_token.sh` script to authenticate with CodeArtifact
- A `[[tool.poetry.source]]` section in pyproject.toml pointing to the artifact repository

Before installing dependencies in these projects, run:
```bash
. ./ca_token.sh
```

## Testing Approach

### Python Projects
- Most use pytest with various plugins (pytest-cov, pytest-mock, pytest-httpx)
- Test files typically follow the pattern `*_test.py` or are in `tests/` directories
- Run a single test: `poetry run pytest path/to/test.py::TestClass::test_method`

### JavaScript Projects
- osmosis-website uses Jest: `npm test`
- Configuration in jest-config.ts or package.json

## Docker Support

Several projects include Docker configurations:
- `theia/` has Dockerfile and compose.yml with make commands for Docker operations
- Use `make build` or `make docker-build` to build Docker images
- Use `make test` to run tests in Docker environment

## Pre-commit Hooks

Many projects have `.pre-commit-config.yaml` files. To set up:
```bash
poetry run pre-commit install  # For Poetry projects
# or
pre-commit install  # If pre-commit is globally installed
```

## Type Checking

### Python
- Projects use mypy for type checking
- Configuration in pyproject.toml under `[tool.mypy]`
- Run: `poetry run mypy .`

### TypeScript
- TypeScript projects have tsconfig.json
- Type checking happens during build or via `npm run typecheck` (if configured)

## Project-Specific Notes

### speechlib
- Audio processing library for speaker diarization and transcription
- Requires CUDA dependencies for GPU execution
- Has example notebooks and voice folder structure for speaker recognition

### osmosis-website
- Gatsby static site with podcast feed plugin
- Uses GitHub-flavored markdown for content
- Has semantic-release for automated versioning
- Cloudflare deployment via Wrangler

### C4 Architecture (c4/)
- Structurizr DSL for architecture documentation
- Export diagrams: `npm run export`
- Uses Puppeteer for diagram generation

### Satellite/Earth Observation Projects
- Many projects (calval_scheduler, theia, temperature-api) are related to satellite data processing
- Often require AWS credentials and S3 access
- Use specialized libraries like rasterio, pyproj, odc-geo for geospatial operations

### TabletopGames (TAG Framework)
- Java-based framework for tabletop game AI research (Maven build system, Java 17+)
- Located in `TabletopGames/` directory
- Build: `mvn compile` | Test: `mvn test` | Run GUI: `mvn exec:java -Dexec.mainClass="gui.Frontend"`

**Core Architecture (three pillars):**
1. **GameState** (`AbstractGameState`) - Pure data container, no game logic
2. **ForwardModel** (`AbstractForwardModel`) - All rules and mechanics, stateless
3. **Players** (`AbstractPlayer`) - Decision-makers receiving game observations

**New Game Implementation Pattern:**
1. `[Game]Parameters extends TunableParameters` - Configuration
2. `[Game]GameState extends AbstractGameState` - State representation
3. `[Game]ForwardModel extends StandardForwardModel` - Rules (or `AbstractRuleBasedForwardModel` for complex games)
4. Custom actions extending `AbstractAction` as needed
5. Register in `GameType` enum

**Key Components:** `GridBoard`, `Deck<T>`, `Card`, `Token`, `Counter`, `Area`
**Turn Management:** `IGamePhase` interface, `TurnOrder` classes
**Template:** See `src/main/java/gametemplate/` for scaffolding

## Code Style

### Imports
- Always use module-level imports at the top of files
- Never use inline/function-level imports to work around circular dependencies
- For circular import issues: prefer code duplication, module restructuring, or creating new shared modules over inline imports

### Comments
- Do not add inline comments to code
- Docstrings are acceptable for functions and classes
- Code should be self-explanatory; if it's unclear, the user will ask for clarification

### Variable Names
- Prefer expanded names
    - `uncertainty_temperature` in favour of `u_t`

## Writing out thoughts
- When asked to export content please use:
    - Markdown
    - ~/Documents/Development/claude-exports/

## General Sentiment
- Please do not congratulate me on things you or I do


## Jupyter Notebook Editing

When editing Jupyter notebooks (.ipynb files):
- **Always use the `NotebookEdit` tool** for adding, modifying, or deleting cells
- **Never use Bash/Python scripts** to manipulate notebook JSON directly
- NotebookEdit provides reviewable diffs that allow acceptance/rejection of changes
- For new cells, use `edit_mode=insert` with the appropriate `cell_id` to position the cell


## Research Study Workflow

When the user says **"let's begin a new study"** (or similar), follow this collaborative research workflow:

### 1. Setup
- Create a research plan markdown file in `~/Documents/Development/claude-exports/[study_name]_research_plan.md`
- Create or identify a Jupyter notebook for the analysis
- Establish the research question and success criteria upfront

### 2. Research Plan Structure
The plan document should contain:
- **Overview**: Research question, status, notebook location
- **Progress Summary**: Completed phases, in-progress work, pending items
- **Key Questions**: What we're trying to answer (update with answers as found)
- **Success Criteria**: Checkboxes for completion
- **Notes**: Insights, caveats, and context discovered during analysis

### 3. Iterative Development
- Work in phases, updating the plan after each milestone
- Keep the plan as the source of truth for methodology decisions
- Use the notebook for implementation and visualisation
- Pause to discuss findings and adjust direction as needed

### 4. Narrative Integration
As the study matures:
- Weave "why" context into notebook markdown cells
- Structure notebook with clear parts (Problem → Analysis → Conclusions)
- Document methodological improvements and their impact
- Ensure the notebook tells a coherent story for future readers

### 5. Wrap-up
- Add conclusions section summarising key findings
- Document recommendations and future work
- Prepare for report generation (plot tweaks, narrative polish)

### Example Studies
- `atmospheric_correction_larger_footprints_research_plan.md` + `cams_over_larger_footprints.ipynb`

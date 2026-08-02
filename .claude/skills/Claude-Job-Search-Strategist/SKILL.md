```markdown
# Claude-Job-Search-Strategist Development Patterns

> Auto-generated skill from repository analysis

## Overview
This skill teaches you the core development patterns and conventions used in the `Claude-Job-Search-Strategist` TypeScript codebase. You'll learn how to structure files, write imports/exports, follow commit conventions, and organize tests. This guide ensures consistency and maintainability across the project.

## Coding Conventions

### File Naming
- Use **camelCase** for all file names.
  - Example: `jobSearchUtils.ts`, `resumeParser.test.ts`

### Import Style
- Use **relative imports** for referencing other files.
  - Example:
    ```typescript
    import { parseResume } from './resumeParser';
    ```

### Export Style
- Use **named exports** for all modules.
  - Example:
    ```typescript
    // In jobSearchUtils.ts
    export function filterJobs(jobs: Job[], criteria: Criteria): Job[] {
      // implementation
    }
    ```

### Commit Messages
- Follow **conventional commit** style.
- Use prefixes like `chore`.
- Keep commit messages concise (average ~65 characters).
  - Example: `chore: update dependencies for security patches`

## Workflows

_No automated workflows detected in this repository._

## Testing Patterns

- Test files use the `*.test.*` naming pattern.
  - Example: `resumeParser.test.ts`
- Testing framework is **unknown**, but tests are colocated with source files or in a `tests` directory.
- Example test file structure:
  ```typescript
  import { parseResume } from './resumeParser';

  describe('parseResume', () => {
    it('should extract skills from resume text', () => {
      // test implementation
    });
  });
  ```

## Commands
| Command | Purpose |
|---------|---------|
| /conventions | Review coding conventions for this repo |
| /test-patterns | Show how to write and organize tests |
```
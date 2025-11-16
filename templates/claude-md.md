---
title: Claude.md Template
description: Personal instructions for Claude Code projects
version: 1.0.0
---

# Claude.md Template

Use this template to create consistent `claude.md` files across your projects. Place the file at the root of any project where you use Claude Code.

```markdown
# [Project Name] - Claude Instructions

## Project Overview
Brief description of the project, its goals, and scope.

## Code Structure
Explain the project structure:
- `/src` - Source code
- `/tests` - Test files
- `/docs` - Documentation
- etc.

## Key Technologies
- Framework: [e.g., Next.js, React, Node.js]
- Language: [TypeScript, JavaScript, Python, etc.]
- Key libraries: [list important dependencies]

## Development Setup
```bash
# Clone and install
git clone [repo-url]
cd [project-name]
npm install  # or your package manager

# Run development server
npm run dev

# Run tests
npm test

# Build for production
npm run build
```

## Git & Branching
- Main branch: `main`
- Feature branches: `feature/short-description`
- Bug fixes: `fix/short-description`
- Hotfixes: `hotfix/short-description`

See [CLAUDE.md workflow guidelines](https://github.com/yourusername/knowledge-center/blob/main/guides/git-workflow.md) for detailed guidance.

## Code Style & Conventions
- **Formatting:** [Prettier / ESLint / other]
- **Naming:** camelCase for variables/functions, PascalCase for classes/components
- **Comments:** Add comments for non-obvious logic only
- **File organization:** [Your conventions]

## Important Patterns & APIs
### Pattern 1: [Pattern Name]
When to use: ...
Example:
```
code example
```

### Pattern 2: [Pattern Name]
When to use: ...
Example:
```
code example
```

## Common Tasks

### Adding a New Feature
1. Check if there's a GitHub issue
2. Create a branch: `feature/feature-name`
3. Write code following project conventions
4. Write/update tests
5. Create a PR with clear description
6. Wait for review and merge

### Fixing a Bug
1. Create a branch: `fix/bug-description`
2. Reproduce the bug with a test (if possible)
3. Fix the bug
4. Verify the test passes
5. Create a PR
6. Merge after review

### Running Tests
```bash
# Run all tests
npm test

# Run specific test file
npm test src/components/__tests__/Component.test.tsx

# Run with coverage
npm test -- --coverage
```

## Testing Guidelines
- Write tests for new features
- Aim for [X]% code coverage
- Use [testing library/framework name]
- Test user behavior, not implementation details

## Performance Considerations
- [Key optimization techniques used]
- [Performance metrics to monitor]
- [Tools for profiling/monitoring]

## Deployment
- **Environment:** [staging / production]
- **Deployment process:** [automated / manual]
- **Where to deploy:** [Vercel / AWS / other]
- **Configuration:** Environment variables needed

```bash
# Example deployment
npm run build
npm run deploy
```

## Debugging Tips
- **Issue:** Common problem
  **Solution:** How to debug/fix
- **Issue:** Common problem
  **Solution:** How to debug/fix

## External Dependencies & Third-Party Services
- [Service/Library Name]: [What it does, how to use, where config is]
- [Service/Library Name]: [What it does, how to use, where config is]

## Important Files & Locations
- **Config file:** `/path/to/config`
- **Environment setup:** `.env.example`
- **Main entry point:** `/src/index.ts`
- **Database schema:** `/db/schema.sql`

## Documentation Links
- [API Documentation](link)
- [Architecture Guide](link)
- [Database Schema](link)
- [Deployment Guide](link)

## Communication & Review
- **Code reviews:** Everyone reviews everyone's code
- **PR naming:** Clear, descriptive titles
- **Slack channel:** [#channel-name]
- **Decision log:** [link to decision log]

## Common Issues & Solutions

### Issue: [Common Problem]
**Symptoms:** What you see
**Root cause:** Why it happens
**Fix:** How to resolve
**Prevention:** How to avoid in future

### Issue: [Common Problem]
**Symptoms:** What you see
**Root cause:** Why it happens
**Fix:** How to resolve
**Prevention:** How to avoid in future

## Tools & Commands Cheatsheet
```bash
# [Command name] - what it does
command-name [args]

# [Command name] - what it does
command-name [args]
```

## When to Ask for Help
- Architecture decisions
- Complex refactors
- Security concerns
- Performance optimizations
- Breaking changes

## Updates & Maintenance
This file should be updated when:
- Project structure changes
- New major patterns emerge
- Tools/dependencies change
- New team members join
- Processes are clarified

**Last updated:** [Date]
**Updated by:** [Name/you]
```

## How to Use This Template

1. Copy this template to your project root as `claude.md`
2. Replace placeholders with your project-specific information
3. Keep it updated as your project evolves
4. Reference it when asking Claude Code for help with your project

## Tips for Effective Claude.md Files

- Keep it concise but complete
- Focus on project-specific information
- Include real examples and code snippets
- Update it regularly as things change
- Highlight common gotchas and solutions
- Make it easy to scan and find information

See [Claude.md Best Practices](link) for more guidance.

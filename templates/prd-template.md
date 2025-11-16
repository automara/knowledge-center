---
title: PRD Template
description: Product Requirements Document template for Claude Code projects
version: 1.0.0
---

# PRD: [Feature/Project Name]

**Status:** [Draft / In Review / Approved]
**Date Created:** YYYY-MM-DD
**Last Updated:** YYYY-MM-DD
**Owner:** [Your Name]
**Related Issue:** #[issue-number]

## Overview

### Problem Statement
Clearly describe the problem this feature/project solves. Who is affected? Why does it matter?

### Solution Summary
Brief, high-level description of what we're building to solve the problem.

### Success Criteria
How will we know this is successful? Define measurable outcomes.
- Criteria 1
- Criteria 2
- Criteria 3

## User Stories

### User Story 1
```
As a [user type]
I want [feature/capability]
So that [benefit/outcome]
```

**Acceptance Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

### User Story 2
```
As a [user type]
I want [feature/capability]
So that [benefit/outcome]
```

**Acceptance Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## Requirements

### Functional Requirements
What the system must do:
1. Requirement 1: Description
2. Requirement 2: Description
3. Requirement 3: Description

### Non-Functional Requirements
Performance, security, scalability, etc.:
1. Requirement 1: Description
2. Requirement 2: Description
3. Requirement 3: Description

### Constraints & Assumptions
- Constraint/Assumption 1
- Constraint/Assumption 2
- Constraint/Assumption 3

## Technical Specification

### Architecture Overview
How will this be implemented at a high level? Include diagrams if helpful.

### Technology Stack
- [Technology]: [Why this choice]
- [Technology]: [Why this choice]
- [Technology]: [Why this choice]

### Key Components
```
Component 1
├── Subcomponent 1.1
├── Subcomponent 1.2
└── Subcomponent 1.3

Component 2
├── Subcomponent 2.1
└── Subcomponent 2.2
```

### Data Model
```
Entity: User
- id: string
- name: string
- email: string
- created_at: timestamp

Entity: [Another Entity]
- field1: type
- field2: type
```

### API Endpoints
If applicable, list major endpoints:

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/api/resource` | Get list of resources |
| POST | `/api/resource` | Create new resource |
| GET | `/api/resource/:id` | Get specific resource |
| PUT | `/api/resource/:id` | Update resource |
| DELETE | `/api/resource/:id` | Delete resource |

### Integration Points
- External services needed
- Third-party APIs
- Internal system dependencies

## Design & UX

### User Interface
Description of the UI, wireframes, or mockups (link to Figma, etc.)

### User Experience Flow
Step-by-step description of how users interact with the feature.

1. User does action A
2. System responds with X
3. User sees result Y
4. etc.

### Accessibility Considerations
- WCAG compliance level
- Keyboard navigation
- Screen reader support
- Color contrast

## Implementation Plan

### Phase 1: [Phase Name]
Timeline: [Start date] - [End date]
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

### Phase 2: [Phase Name]
Timeline: [Start date] - [End date]
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

### Phase 3: [Phase Name]
Timeline: [Start date] - [End date]
- [ ] Task 1
- [ ] Task 2
- [ ] Task 3

### Dependencies
- Dependency 1
- Dependency 2
- What must be done first

### Risks & Mitigation
| Risk | Impact | Likelihood | Mitigation |
|------|--------|------------|-----------|
| [Risk 1] | [Impact] | [High/Medium/Low] | [How to mitigate] |
| [Risk 2] | [Impact] | [High/Medium/Low] | [How to mitigate] |

## Testing Strategy

### Unit Tests
- Component 1: [test coverage target]
- Component 2: [test coverage target]

### Integration Tests
- Test flow 1
- Test flow 2
- Test flow 3

### User Acceptance Testing
- Test scenario 1
- Test scenario 2
- Test scenario 3

### Performance Testing
- Load test: [expected capacity]
- Response time: [expected latency]
- Resource usage: [expected limits]

## Rollout Plan

### Beta/Staging
- [ ] Deploy to staging
- [ ] Internal testing
- [ ] Performance verification
- [ ] Security review

### Production Rollout
- [ ] Gradual rollout: [% users]
- [ ] Monitoring setup
- [ ] Support preparation
- [ ] Documentation ready

### Rollback Plan
If something goes wrong:
1. How to revert
2. Communication plan
3. User impact mitigation

## Monitoring & Metrics

### Key Metrics
- Metric 1: [what to track]
- Metric 2: [what to track]
- Metric 3: [what to track]

### Success Metrics
- KPI 1: [success threshold]
- KPI 2: [success threshold]
- KPI 3: [success threshold]

### Monitoring & Alerts
- Alert 1: [condition and action]
- Alert 2: [condition and action]
- Dashboard: [link if exists]

## Documentation Requirements
- [ ] API documentation
- [ ] User guide
- [ ] Internal runbook
- [ ] Architecture documentation
- [ ] Troubleshooting guide

## Future Considerations

### Out of Scope (for this phase)
- Feature that could be added later
- Enhancement that's not critical now
- Integration that's deferred

### Future Enhancements
- Potential improvement 1
- Potential improvement 2
- Long-term vision

## Approval & Sign-Off

| Role | Name | Date | Signature |
|------|------|------|-----------|
| Product Owner | | | |
| Tech Lead | | | |
| Design Lead | | | |

## Questions & Discussion
- [Question/discussion point 1]
- [Question/discussion point 2]
- [Question/discussion point 3]

## Appendix

### References
- [Link to research]
- [Link to inspiration]
- [Link to similar feature]

### Additional Resources
- [Relevant documentation]
- [Tools/libraries to evaluate]
- [Competitive analysis]

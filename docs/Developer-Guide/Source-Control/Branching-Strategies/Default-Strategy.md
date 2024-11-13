---
title: Default Strategy
parent: Branching Strategies
layout: page
grand_parent: Source Control
nav_order: 1
---

The default strategy, relies on pull requests into the main branch, the pipelines will then automatically push out a new release branch for the impacted repository and any dependencies.

```mermaid
gitGraph:
    commit
    branch issues/1-example order: 1
    commit
    switch main
    merge issues/1-example
    commit id: "PR issue 1 to main"

    branch release/0.1.0 order: 3
    checkout release/0.1.0
    commit id: "Release 0.1.0"
    switch main
    commit

    branch issues/2-example order: 2
    commit
    commit
    commit
    switch main
    merge issues/2-example
    commit id: "PR issue 2 to main"
    
    branch release/0.1.1 order: 4
    checkout release/0.1.1
    commit id: "Release 0.1.1"
    
    switch release/0.1.0
    branch hotfix/3-example order: 5
    checkout hotfix/3-example
    commit
    switch release/0.1.0
    merge hotfix/3-example
    commit id: "PR to release branch"

    switch main
    merge release/0.1.0
    commit id: "PR from release to main"

    branch release/0.1.2 order: 6
    checkout release/0.1.2
    commit id: "Release 0.1.2"

```

The downside of this strategy is that it will create a large number of branches on each repository, however this is on purpose as it will automatically update the various flux configurations, helm charts, image versions, etc making it easier to manage the large number of repositories overall. 
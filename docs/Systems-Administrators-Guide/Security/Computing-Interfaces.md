---
title: Computing Interfaces
parent: Security
grand_parent: Systems Administrators Guide
layout: page
---

This page will outline how the solution handles various computing interfaces and enforces security to prevent misuse.

## Clipboard
By default, the solution prevents copying data out of the TRE via the system clipboard. Clipboard functionality is disabled entirely when connecting to the solution via Apache Guacamole.

## Workspace Isolation
Each workspace is isolated from all of the other workspaces, this ensures that data cannot be transferred between the workspaces. This is an essential premise to the design of the TRE and one of the core [functional requirements](../../Architecture.md) of the solution architecture.

## Focus on Useability
The solution is designed with a focus on useability, many of the [tools](../../Researcher-Guide/Available-Tools.md) provided should therefore be familiar to the majority of research engineers. IDE's such as [RStudio](../../Researcher-Guide/Available-Tools/IDES/RStudio.md), code server and Jupyter Labs should allow research engineers to move forward with their research projects quickly, without having to learn an entirely new tech stack.
# Whale Rider V4 - Core Architecture Overview

**Property of Castle Trade LLC. strictly confidential.**

## System Topology
Whale Rider V4 is built on a multi-process asynchronous architecture designed for sub-millisecond execution and high-frequency market engagement. The system is heavily optimized for AWS EC2 low-latency environments.

### 1. Master Orchestrator (`src/core/`)
Handles the lifecycle of all subordinate processes using Python's `multiprocessing` library. Ensures zero-downtime operation and manages automatic restarts via the SRE recovery protocols.

### 2. IPC & Shared Memory Layer (`/dev/shm`)
To bypass the latency overhead of standard database reads, tick data and orderbook snapshots are streamed directly into shared memory segments. This allows the Alpha Logic models to read data in O(1) time complexity.

### 3. Risk Gatekeepers (`src/risk/`)
Before any order reaches the exchange adapter, it must pass through the hardware-level Risk Gatekeepers.
* **Notional Guard:** Prevents over-exposure based on dynamic account equity.
* **Slippage Padding:** Calculates expected institutional slippage and auto-cancels orders if the theoretical fill price breaches the defined threshold.

### 4. Exchange Adapters (`src/adapters/`)
Optimized WebSockets and REST fallback wrappers utilizing CCXT asynchronous methods for direct order routing.

---
*Note: This repository contains the structural skeleton and architectural interfaces only. Proprietary Alpha generation logic, order flow classification models, and live production keys are maintained in separate, encrypted environments.*

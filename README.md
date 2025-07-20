# 🪙 Upgradable Staking Contract With Emission

A simple and gas-efficient ETH staking system with upgradeable logic. Users stake ETH and earn COCO tokens over time.

---

## 🧩 Components

- **COCOcoin.sol** – ERC20 reward token with minting restricted to the staking contract.
- **StakingContract.sol** – Proxy contract using `delegatecall` for upgradeability.
- **StakingContractImplementation.sol** – Main logic: stake, unstake, claim rewards.

---

## 🚀 How It Works

1. Users stake ETH via the proxy.
2. Rewards accumulate over time, calculated by `stake * time`.
3. Rewards are claimed in COCO tokens, minted by the contract.

---

## 🔁 Upgrade Process

- Owner can update logic using `updateImplementation()` on the proxy.
- Implementation must be deployed separately and contain no constructor logic.

---



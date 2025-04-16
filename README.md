# 🚨 FiveM Anti-Cheat System 🚨

## **Overview**

Welcome to the **FiveM Anti-Cheat System**, an advanced detection tool designed to keep your server safe from cheaters! This system actively monitors suspicious activities like **AI behavior anomalies**, **DLL injections**, and **external processes**, all while keeping resource usage in check.

But that's not all — it’s **aggressive**! Once a cheat is detected, the system will **automatically ban** the offender and send detailed logs straight to your Discord channel. Whether you’re running a competitive server or just want a safer place for your players, this anti-cheat system has you covered!

---

## **Key Features** 🌟

- **AI Behavior Monitoring**: Detects unnatural mouse and camera movements. Cheating tools like aimbots will be spotted in no time.
- **External Process Detection**: Flags suspicious external processes (cheat engines, hack tools).
- **DLL Injection Detection**: Keeps track of unauthorized DLLs that might indicate cheating.
- **CPU/RAM Usage Monitoring**: Identifies if a player’s machine is running suspiciously high CPU or RAM usage — a sign of possible cheats.
- **Aggressive Auto-Banning**: No hesitation! Players caught cheating will be banned instantly.
- **Admin Whitelist**: Prevents server admins from being flagged by accident, keeping them in control.

---

## **How It Works 🔧**

This system continuously monitors players’ actions, looking for patterns and anomalies. It tracks:

- **Mouse Movements**: If there are consistent, identical mouse movements or “silent clicks,” it may indicate that a cheat is in use (e.g., a triggerbot).
- **Suspicious Processes**: If a cheat engine or similar tool is running in the background, this will be detected and flagged.
- **System Resource Usage**: If a player’s CPU or RAM usage exceeds certain thresholds, it could mean that a cheat is actively consuming system resources.

Once any suspicious activity is detected, the system **immediately logs the event** and, if set up, **bans** the player for good measure. 

---

## **Installation Guide 📦**

1. **Clone or Download the Anti-Cheat System**
2. **Place `client.lua`, `server.lua`, and `config.lua`** in the appropriate resources folder on your FiveM server.
3. **Configure the `config.lua`** file to suit your server’s needs. Add your Discord Webhook, set tolerances, and manage your admin whitelist.
4. **Start the Resource** in your server and let the system do its magic!

---

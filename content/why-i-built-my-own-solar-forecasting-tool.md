---
title: "Why I Built My Own Solar Forecasting Tool (To Destroy My Energy Bills)"
date: 2026-06-12T22:17:01+01:00
draft: false
author: ["darren horrocks"]
tags: ["programming", "angular", "project"]
---

If you’ve spent any time optimizing a home solar and battery setup, you quickly realize that the hardware is only half the battle. The real challenge is managing it intelligently. To make smart decisions about when to charge your batteries from the grid on cheap night rates, when to hold off, and when to let them drain, you need an accurate solar forecast.

<!--more-->

There are plenty of black-box solar forecasting services out there, but I wanted something entirely under my control. And let's be honest, the ultimate goal here is to spend as absolutely little money as humanly possible on energy bills.

So, I built **Solar Forecast** ([GitHub repo](https://github.com/bizzehdee/solar-forecast)), a self-hosted, lightweight utility that takes raw weather data and translates it into a highly accurate, local generation forecast for your specific hardware setup.

The best part? It relies on **Open-Meteo**, which is an absolutely incredible, developer-friendly public API. Instead of paying for a premium solar forecasting service, I use Open-Meteo's excellent free weather data and do the solar math myself.

### The Goal: Maximum Bill Optimization

When you have a home battery system, every kilowatt-hour counts. If the weather tomorrow is going to be miserable and overcast, you want to charge your batteries to full during the cheap overnight grid window. If tomorrow is going to be a blue-sky scorcher, you want to leave those batteries empty so you can fill them with free sunshine.

Guess wrong, and you're either buying peak-rate electricity from the grid or wasting solar generation because your batteries are already full.

To automate this perfectly without spending a penny on subscription services, I needed a tool that could ingest raw weather data and calculate exactly what my specific arrays would produce hour-by-hour.

### How It Works

Solar Forecast takes the raw, high-quality weather metrics from Open-Meteo—like cloud cover percentages—and runs them through math-based solar radiation models.

1. **Array Configuration:** You define your physical setup (panel tilt, azimuth/orientation, and kWp capacity) in the configuration. It supports multiple arrays seamlessly, which is essential if you have panels split across different roof faces (like an East/West split).
2. **The Solar Math:** The tool calculates the theoretical maximum solar radiation (clear-sky index) for your exact coordinates and solar geometry at any given hour of the day.
3. **The Yield Output:** By applying the cloud cover data to that theoretical maximum, it spits out an accurate estimation of your actual generation.

Because the math happens locally, you aren't tied to a specific smart home ecosystem or a paid third-party platform. You just get clean, actionable data that you can feed into your battery management automation to squeeze every single penny of savings out of your system.

### Keeping It Lean

As a developer, the last thing I want to do is waste server resources on a single-purpose problem. This project is intentionally lightweight and efficient. It doesn't need a massive footprint; it’s a focused utility designed to do one thing incredibly well.

You can see the project page over at [darrenhorrocks.co.uk/solar-forecast](https://www.darrenhorrocks.co.uk/solar-forecast/) to see the concept in action, or grab the source code directly from the [GitHub Repository](https://github.com/bizzehdee/solar-forecast).

If you want to take total control of your energy management, stop guessing your generation, and drive your electricity bills down to the absolute minimum, clone the repo and give it a spin.
---
title: "Time Series Anomaly Detection with ML.NET in C#"
date: 2023-09-19T13:47:33Z
draft: false
tags: ["dotnet", "mlnet", "csharp", "ai", "anomaly-detection", "machine-learning"]
author: ["darren horrocks"]
---

ML.NET provides a very simple way of performing Anomaly Detection on random variables as long as they are independent and identically distributed (i.e. daily sales totals recorded at the end of each and every day). With it also being possible to detect anomalies without requiring past examples beyond your dataset.

<!--more-->

## Prerequisites
Before we get started, make sure you have the following prerequisites:

* Visual Studio with .NET Core or .NET Framework installed.
* Basic understanding of C# programming language.

## Step 1: Set Up Your Project
* Open Visual Studio and create a new C# console application.

## Step 2: Install ML.NET Package
* Right-click on your project in Solution Explorer.
* Select "Manage NuGet Packages..."
* Search for "Microsoft.ML" and install the latest version.

## Step 3: Import Necessary Libraries

```csharp
using Microsoft.ML;
using Microsoft.ML.Data;
```

## Step 4: Define Your Data Classes

In this example, we'll assume you have a class called ```TimeSeriesData``` with two properties: ```TimeStamp``` and ```Value```.

```csharp
public class TimeSeriesData
{
    [LoadColumn(0)]
    public DateTime TimeStamp;

    [LoadColumn(1)]
    public float Value;
}
```

## Step 5: Load and Prepare Your Data
Load your time series data into a ```DataView``` and split it into training and testing sets.

```csharp
var context = new MLContext();
var data = context.Data.LoadFromTextFile<TimeSeriesData>("path/to/your/data.csv", separatorChar: ',');
var dataSplit = context.Data.TrainTestSplit(data);
```

## Step 6: Define Your Model

Choose an anomaly detection algorithm. In this example, we'll use the ```SrCnnEntireAnomalyDetector``` algorithm.

```csharp
var pipeline = context.Transforms.DetectAnomalyBySrCnn("Value", nameof(TimeSeriesPrediction.Prediction), 10)
    .Append(context.Transforms.CopyColumns("Prediction", nameof(TimeSeriesPrediction.Prediction)));
```

## Step 7: Train Your Model

```csharp
var model = pipeline.Fit(dataSplit.TrainSet);
```

## Step 8: Make Predictions

```csharp
var predictions = model.Transform(dataSplit.TestSet);
var anomalies = context.Data.FilterRowsByBoolColumn(predictions, "Prediction");
```

## Step 9: Evaluate the Model

```csharp
var metrics = context.AnomalyDetection.Evaluate(dataSplit.TestSet, "Prediction");
Console.WriteLine($"AUC: {metrics.AreaUnderRocCurve}");
```

## Step 10: Interpret the Results

You can now use the ```anomalies``` DataView to analyze and interpret the detected anomalies in your time series data.

## Step 11: Deploy and Use Your Model

To use the model in your application, you can save it and load it as needed:

```csharp
context.Model.Save(model, dataSplit.TrainSet.Schema, "model.zip");
var loadedModel = context.Model.Load("model.zip", out var modelSchema);
```

Congratulations! You've successfully implemented time series anomaly detection using ML.NET in C#. This tutorial provides a basic example, but you can further refine and expand your model based on your specific use case and data.

Remember to replace the placeholders in the code (like "path/to/your/data.csv") with your actual file paths and feel free to experiment with different algorithms, hyperparameters, and techniques to improve the accuracy of your anomaly detection model.

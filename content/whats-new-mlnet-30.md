---
title: "Whats New in ML.NET 3.0"
date: 2023-11-28T09:23:19Z
draft: false
author: ["darren horrocks"]
tags: ["dotnet", "mlnet"]
---

ML.NET is an open-source, cross-platform machine learning framework for .NET developers, offering exciting capabilities in deep learning, data processing, and more. Given that Microsoft [recently announced ML.NET 3.0](https://devblogs.microsoft.com/dotnet/announcing-ml-net-3-0/), let's take a closer look at what ML.NET 3.0 has in store.

<!--more-->

### Deep Learning Takes Center Stage

In ML.NET 3.0, deep learning scenarios have been significantly expanded. The framework now boasts new capabilities in Object Detection, Named Entity Recognition (NER), and Question Answering (QA). These advancements are made possible through seamless integrations with TorchSharp and ONNX models. The integration with LightGBM has also been updated to the latest version, ensuring that you're on the cutting edge of deep learning possibilities.

### Object Detection Unleashed

Object detection, a crucial aspect of computer vision, is now seamlessly integrated into ML.NET 3.0. This functionality allows for more granular image classification, locating and categorizing entities within images. Leveraging TorchSharp-powered Object Detection APIs, ML.NET enables you to work with the latest techniques from Microsoft Research, backed by a state-of-the-art Transformer-based neural network architecture.

```csharp
// Sample code for Object Detection
var chain = new EstimatorChain<ITransformer>();
// ... (code for data processing and model training)
var metrics = ML.MulticlassClassification.EvaluateObjectDetection(
    idv, idv.Schema[2], idv.Schema[boundingBoxColumnName], idv.Schema[predictedLabelColumnName],
    idv.Schema[predictedBoundingBoxColumnName], idv.Schema[scoreColumnName]
);
```

### Named Entity Recognition and Question Answering
Natural Language Processing (NLP) is a common need in software, and ML.NET 3.0 meets this demand head-on. NER and QA scenarios are unlocked in this release, building upon the existing TorchSharp RoBERTa text classification features introduced in ML.NET 2.0. The trainers for both NER and QA are bundled within the Microsoft.ML.TorchSharp 3.0.0 package.

```csharp
// Sample code for QA trainer
var chain = new EstimatorChain<ITransformer>();
var estimatorQA = chain.Append(mlContext.MulticlassClassification.Trainers.QuestionAnswer(
    // ... (parameters for QA training)
));

// Sample code for NER trainer
var estimatorNER = chain.Append(mlContext.Transforms.Conversion.MapValueToKey("Label", keyData))
    .Append(mlContext.MulticlassClassification.Trainers.NameEntityRecognition(
        // ... (parameters for NER training)
    ))
    .Append(mlContext.Transforms.Conversion.MapKeyToValue(outputColumn));
```

### Intel oneDAL Training Acceleration
ML.NET 3.0 introduces training hardware acceleration powered by Intel oneDAL (Intel oneAPI Data Analytics Library). This library optimizes data analysis by providing highly optimized algorithmic building blocks, utilizing SIMD extensions in 64-bit architectures found in both Intel and AMD CPUs.

### Automated Machine Learning (AutoML) Empowerment
AutoML experiences in ML.NET get a boost in version 3.0. The AutoML Sweeper now supports Sentence Similarity, QA, and Object Detection. Continuous resource monitoring is introduced to control long-running experiments and avoid crashes.

### DataFrame Revamped
The release includes a plethora of updates to DataFrame, enhancing its capabilities. These updates, contributed by the community, include support for IDataView <-> DataFrame conversions with String and VBuffer column types. Increased data storage capacity, recognition of Apache Arrow Date64 column data, and expanded data loading scenarios from and to SQL databases are some notable improvements.

### Tensor Primitives Integration
ML.NET 3.0 seamlessly integrates with Tensor Primitives (System.Numerics.Tensors), introducing support for tensor operations and bringing about notable performance improvements. Benchmark results targeting .NET 8 showcase the efficiency gains achieved through this integration.

ML.NET 3.0 is a game-changer for .NET developers diving into machine learning. With enhanced deep learning capabilities, streamlined data processing, and integration with cutting-edge technologies, it opens up a world of possibilities. Whether you're into computer vision, natural language processing, or automated machine learning, ML.NET 3.0 has something for everyone. Dive into the release notes for a comprehensive view of all the updates and start exploring the future of machine learning with ML.NET!
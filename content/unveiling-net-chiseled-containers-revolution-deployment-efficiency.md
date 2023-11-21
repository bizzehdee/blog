---
title: ".NET Chiseled Containers: A Revolution in Deployment Efficiency"
date: 2023-11-21T15:02:35Z
draft: false
author: ["darren horrocks"]
tags: ["dotnet", "containers", "docker", "devops"]
---

In a groundbreaking announcement, Canonical and Microsoft have declared the general availability of ".NET Chiseled Ubuntu container images" for production use with .NET 6, 7, and 8. This release is the culmination of a year-long partnership and design collaboration between the two tech giants, aimed at optimizing containerized applications for size, security, and efficiency.

<!--more-->

## What are Chiseled Containers?

Chiseled containers represent a paradigm shift in container image design philosophy. Traditional container images often include a multitude of unnecessary components, leading to larger sizes and increased security vulnerabilities. The core concept behind chiseled containers is to meticulously trim away non-essential elements, creating a lean and secure deployment vehicle for cloud applications.

## Key Features of Chiseled Containers

### 1. Size and Security Optimization

One of the primary challenges in managing container images is handling Common Vulnerabilities and Exposures (CVEs). Chiseled containers address this issue by significantly reducing the number of components, thereby minimizing the attack surface. A comparative analysis using anchore/syft commands demonstrates a stark difference in the number of components between chiseled and non-chiseled images.

```bash
$ docker run --rm anchore/syft mcr.microsoft.com/dotnet/runtime:8.0 | grep deb | wc -l
92
$ docker run --rm anchore/syft mcr.microsoft.com/dotnet/runtime:8.0-jammy-chiseled | grep deb | wc -l
7
```

The reduction in component count enhances the security posture and simplifies CVE management.

### 2. Smaller Image Footprint

Chiseled containers boast a significantly smaller footprint compared to their non-chiseled counterparts. For instance, the uncompressed size of the .NET aspnet image is approximately 110MB for the chiseled variant, rivaling the size of Alpine, a well-known lightweight base image.

```bash
$ docker images --format "table {{.Repository}}\t{{.Tag}}\t{{.Size}}" | grep mcr.microsoft.com/dotnet/aspnet
mcr.microsoft.com/dotnet/aspnet               8.0-jammy-chiseled                      110MB
mcr.microsoft.com/dotnet/aspnet               8.0-alpine                              112MB
```

This reduction in size contributes to faster image pull times and optimized resource utilization.

### 3. Distroless Form Factor

Chiseled containers embody the distroless form factor, emphasizing only the essential components required for application execution. Unlike traditional Linux distributions, they exclude unnecessary tools and package managers, leading to a more secure runtime environment.

## How to Use .NET Chiseled Containers

### 1. Tag and Versioning

Chiseled container images are available in the container repositories with the following tag: `8.0-jammy-chiseled`. The version number may vary for .NET 6 and 7 variants.

### 2. Image Selection

Selecting the appropriate image type depends on the deployment requirements:

- **Framework-Dependent Deployment:**
  - Maximum layer sharing for faster build times.
  - Recommended for hosting multiple .NET apps on the same machine.

- **Self-Contained Apps:**
  - Significantly smaller image size but limited layer sharing.
  - Suitable for scenarios where size optimization is a priority.

- **Native AOT (Ahead-of-Time) Apps:**
  - Further reduces image size, particularly for console apps and services.

### 3. Security Considerations

Chiseled containers enhance security by excluding shells, package managers, and minimizing the attack surface. Furthermore, these containers are shipped as non-root, limiting the potential impact of malicious activities.

## Adoption and Future Outlook

Chiseled containers represent a significant advancement in the .NET container image portfolio. While .NET 8 users are the most immediate beneficiaries, users of Ubuntu and Debian stand to gain substantial size savings by adopting chiseled containers.

Microsoft and Canonical recommend careful consideration of chiseled containers, emphasizing their benefits in terms of reduced image size, enhanced security, and simplified CVE management. The collaboration between the two companies signals a commitment to ongoing support and potential advancements in containerization.

In conclusion, the era of chiseled containers has arrived, promising a revolution in how developers approach containerized application deployment. As the adoption of chiseled containers grows, it is anticipated that other developer ecosystems, such as Java, Python, and Node.js, will explore and offer their own versions of chiseled images. The future of containerization looks more efficient, secure, and streamlined with the introduction of .NET chiseled containers.
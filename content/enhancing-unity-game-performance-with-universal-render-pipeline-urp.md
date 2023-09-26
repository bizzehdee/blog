---
title: "Enhancing Unity Game Performance with Universal Render Pipeline (URP)"
date: 2023-09-26T10:35:44+01:00
draft: false
author: ["darren horrocks"]
tags: ["unity", "urp", "optimisation", "game-dev"]
---

The Universal Render Pipeline (URP) is a powerful tool that can significantly improve the performance of your Unity game. By leveraging its features and implementing optimisation techniques, you can create a smoother and more responsive gaming experience. In this article, we'll explore key strategies for performance tuning in Unity games using the URP pipeline. When I started using unity, I had no idea what it was that I was missing, so to help you get started, here are a list of things any Unity developer should know about, and look up.

<!--more-->

## Utilise GPU Instancing

GPU instancing allows multiple objects with the same material to be rendered in a single draw call. This reduces the overhead associated with making separate draw calls for each object.

```csharp
void Start()
{
    Renderer renderer = GetComponent<Renderer>();
    if (renderer != null)
    {
        renderer.material.enableInstancing = true;
    }
}
```

## Optimise Shaders

URP offers a Shader Graph that allows for visually designing shaders. Keep these tips in mind:

* **Simplify Shaders:** Avoid complex operations in shaders, especially within fragment shaders.
* **Use LODs for Shaders:** Employ Level of Detail techniques for shaders to reduce complexity for distant objects.

## Texture Compression and Atlasing

Optimise textures to reduce memory usage and enhance rendering performance:

* Use compressed texture formats like **ASTC**, **BC7**, or **ETC2**.
* Combine multiple textures into atlases to reduce draw calls
    * **Generate or Collect Textures:** Gather the individual textures you want to include in the atlas.
    * **Create Atlas Texture:** Use a graphics editing tool (e.g., Photoshop) to create a new image file, which will serve as the atlas.
    * **Arrange Textures:** Place the individual textures within the atlas, organizing them to minimize wasted space.
    * **Import into Unity:** Import the atlas texture into your Unity project.
    * **Apply Atlas to Materials:** Modify materials to use the atlas texture instead of individual textures.
    * **Adjust UV Mapping:** Ensure that UV mapping for the objects corresponds correctly to the atlas.

## Implement Occlusion Culling

Occlusion culling prevents the rendering of objects that are not visible to the camera. This reduces GPU workload.

## Level of Detail (LOD)

LOD techniques involve using lower-polygon models or simplified textures for distant objects. URP provides tools for LOD implementation.

### Prepare LOD Models

* Create simplified versions of your object with fewer polygons for varying distances.

### Add LOD Group

* Select the object in the Hierarchy.
* Add the LOD Group component.

### Assign LOD Levels

* In the LOD Group, add LOD levels and assign corresponding models.
* Set Screen Relative Transition Height for each level.

### Test and Adjust

* Enter Play mode to observe LOD switching.
* Fine-tune transition distances if needed.

### Optimise LOD Models

* Ensure LOD models are well-optimised for performance.

### Verify Performance

* Test on different devices to ensure desired performance improvements.

LOD is effective for objects like terrain, foliage, and complex structures. Apply it to objects with a significant impact on performance.

## Particle System Optimisation

Efficiently managing particle systems is crucial for performance:

* Limit the number of particles emitted at a time.
* Use GPU simulation if suitable for your project.

## Minimise Overdraw

Overdraw occurs when multiple transparent objects are rendered on top of each other. This can be mitigated with techniques such as:

* Sorting objects by depth to minimise overdraw.
* Utilizing techniques like depth pre-pass.

## Optimise Post-Processing Effects

Post-processing effects can be resource-intensive. Consider:

* Disabling or reducing the intensity of non-essential effects.
* Using URP's built-in optimisations for post-processing.

## GPU-Driven Rendering

URP leverages GPU for various rendering tasks. Maximize its potential by utilizing Compute Shaders and other GPU-driven techniques.

## Test on Target Hardware

Always test your game on the actual target hardware to ensure optimal performance. This allows you to uncover platform-specific issues and fine-tune accordingly.

## Conclusion

Leveraging the Universal Render Pipeline in Unity provides a powerful set of tools for optimising game performance. By utilizing GPU instancing, optimising shaders, managing textures efficiently, and implementing various other techniques, you can create a high-performing game across a range of devices. Remember, continuous testing and iteration are crucial for achieving the best possible performance.





using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HorizontalChangeScene : MonoBehaviour
{
    public Material TransitionMaterial;

    void OnRenderImage(RenderTexture src,RenderTexture dst)
    {
        Graphics.Blit(src,dst,TransitionMaterial);
    }
}

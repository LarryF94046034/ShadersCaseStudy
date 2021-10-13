using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMove : MonoBehaviour
{
    public Shader myShader;
    public Material graphicMat;
    // Start is called before the first frame update
    void Start()
    {
        graphicMat.shader=myShader;
    }

    void OnRenderImage(RenderTexture src/*拿到的結果*/, RenderTexture dest/*更改後傳遞給這個*/)
    {
        Graphics.Blit(src,dest,graphicMat);  //傳遞的function，指定一個material
    }
}

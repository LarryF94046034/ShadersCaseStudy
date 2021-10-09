Shader "Hidden/Loading"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Speed("Speed",Float)=2
    }
    SubShader
    {
        // No culling or depth
        //Cull Off ZWrite Off ZTest Always   //避免其他渲染流程影響
        Blend SrcAlpha OneMinusSrcAlpha // Traditional transparency   //開啟ALPHA渲染

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float _Speed;

            fixed4 frag (v2f i) : SV_Target
            {
                //起
                float2 tmpUV=i.uv;   //取UV

                

                tmpUV-=float2(0.5,0.5);   //1.平移到原點

                if(length(tmpUV)>0.5)  //平移到原點後 剔除大於半徑0.5的=半徑0.5的圓形UV
                {
                    return fixed4(0,0,0,0);
                }

                float2 finalUV=0;    //最終       //2.聲明最後UV及旋轉度數
                float angle=_Time.x*_Speed;  //隨時間轉的度數

                finalUV.x=tmpUV.x*cos(angle)+(tmpUV.y*-sin(angle));
                finalUV.y=tmpUV.x*sin(angle)+tmpUV.y*cos(angle);

                tmpUV+=float2(0.5,0.5);   //1.平移回初始點
                //尾
                fixed4 col = tex2D(_MainTex, finalUV);
                // just invert the colors
                //col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}

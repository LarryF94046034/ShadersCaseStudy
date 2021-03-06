Shader "Hidden/Pokemon"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Cutoff ("Cutoff", Range(0,1)) = 0 
        _Color ("Color",Color) = (1,1,1,1) 
        _Color1 ("Color1",Color) = (1,1,1,0) 
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always
        //AlphaTest Greater [_Cutoff]  //2.0沒用
        Blend SrcAlpha OneMinusSrcAlpha // Traditional transparency
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
            float _Cutoff;
            fixed4 _Color;
            fixed4 _Color1;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
                col.rgb = 1 - col.rgb;

                if(i.uv.x<_Cutoff)
                    return _Color;
                if(i.uv.x>_Cutoff)
                    return fixed4(0,0,0,0);



                // if(i.uv.y<_Cutoff)
                //     return _Color;
                // if(i.uv.y>_Cutoff)
                //     return fixed4(0,0,0,0);


                // if(i.uv.y<=0.5-_Cutoff)
                //     return _Color;
                // if(i.uv.y>0.5+_Cutoff)
                //     return _Color;

                
                
                return fixed4(0,0,0,0);
            }
            ENDCG
        }
    }
}

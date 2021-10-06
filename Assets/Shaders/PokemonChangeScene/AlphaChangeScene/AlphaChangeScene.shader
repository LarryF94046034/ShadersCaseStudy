Shader "Hidden/Pokemon"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _TransitionTex ("TransitionTex", 2D) = "white" {}
        _Cutoff ("Cutoff", Float) = 0 
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
            sampler2D _TransitionTex;
            float _Cutoff;
            fixed4 _Color;
            fixed4 _Color1;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 transit = tex2D(_TransitionTex, i.uv);
                // just invert the colors
                //transit.rgb = 1 - transit.rgb;

                if(transit.b<_Cutoff)
                    return _Color;
                
                
                return fixed4(0,0,0,0);
            }
            ENDCG
        }
    }
}

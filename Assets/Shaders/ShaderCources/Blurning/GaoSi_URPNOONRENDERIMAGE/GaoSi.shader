Shader "Hidden/GaoSi"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _AmbientLength ("AmbientLength",Float)=0.001
    }
    SubShader
    {
        // No culling or depth
        //Cull Off ZWrite Off ZTest Always

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
            float _AmbientLength;

            fixed4 frag (v2f i) : SV_Target
            {
                float2 tmpUV=i.uv;
                //float ambient=0.001;

                fixed4 col = tex2D(_MainTex, tmpUV);
                fixed4 col12=tex2D(_MainTex, tmpUV+float2(-_AmbientLength,0));
                fixed4 col13=tex2D(_MainTex, tmpUV+float2(0,-_AmbientLength));
                fixed4 col14=tex2D(_MainTex, tmpUV+float2(_AmbientLength,0));
                fixed4 col15=tex2D(_MainTex, tmpUV+float2(0,_AmbientLength));

                col=(col+col12+col13+col14+col15)/(5.0);
                //col=col+col12;
                //col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}

Shader "Hidden/Wave"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Amplitude("Amplitude",Float)=1
        _Frequency("Frequency",Float)=0.5
        _Speed("Speed",Float)=0.5
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            // Upgrade NOTE: excluded shader from DX11; has structs without semantics (struct appdata members _Speed,_Amplitude,_Frequency)
            #pragma exclude_renderers d3d11
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

            float _Speed;
            float _Amplitude;
            float _Frequency;

            v2f vert (appdata v)
            {
                v2f o;
                //起
                float timer=_Time.y;
                float waver=_Amplitude*sin(v.vertex.x*_Frequency/*隨X軸變化*/+timer/*時間*/);
                v.vertex.y=v.vertex.y+waver
                //尾
                o.vertex = UnityObjectToClipPos(v.vertex);  //計算頂點位置(在這之前變換位置)
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            
            

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
                col.rgb = 1 - col.rgb;
                return col;
            }
            ENDCG
        }
    }
}

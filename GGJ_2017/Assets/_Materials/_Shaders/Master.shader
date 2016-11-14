Shader "Custom/Master" {
	Properties {
		_MainTex ("Albedo (RGB); Emissive (A)", 2D) = "black" {}
		_Color ("Color", Color) = (1,1,1,1)
		_Metalness ("Metalness (RGB); Gloss (A)", 2D) = "Black"{}
		_MetalMulti ("Metalness Multiplier", Range(0,1)) = 1.0
		_SmoothnessMulti ("Smoothness Multiplier", Range(0,1)) = 1.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _MetalTex;
		half _MetalMulti;
		half _SmoothnessMulti;

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;

		void surf (Input IN, inout SurfaceOutputStandard o) {
			
			fixed4 a = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 m = tex2D (_MetalTex, IN.uv_MainTex);

			o.Albedo = a*_Color;
			o.Emission = a*a.a;
			o.Metallic = m * _MetalMulti;
			o.Smoothness = m.a * _SmoothnessMulti;

		}
		ENDCG
	}
	FallBack "Diffuse"
}

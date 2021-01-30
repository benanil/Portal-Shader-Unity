// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Anil/Amplify Portal Shader"
{
	Properties
	{
		_Strenght("Strenght", Float) = 21.36
		_Scale("Scale", Float) = 2.39
		[HDR]_Color0("Color 0", Color) = (0.3423572,1.261316,0.180188,0)
		_Speed("Speed", Float) = 0.1
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		
		#include "UnityShaderVariables.cginc"

		#pragma target 2.0
		#pragma surface surf Unlit alpha:fade keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd 
		
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform half4 _Color0;
		uniform sampler2D _TextureSample0;
		uniform half4 _TextureSample0_ST;
		uniform half _Scale;
		uniform half _Strenght;
		uniform half _Speed;

		float2 voronoihash3( float2 p )
		{
			p = float2( dot( p, float2( 127.1, 311.7 ) ), dot( p, float2( 269.5, 183.3 ) ) );
			return frac( sin( p ) *43758.5453);
		}

		float voronoi3( float2 v, float time, inout float2 id, inout float2 mr, float smoothness )
		{
			half2 n = floor( v );
			half2 f = frac( v );
			half F1 = 8.0;
			half F2 = 8.0; float2 mg = 0;
			for ( int j = -1; j <= 1; j++ )
			{
				for ( int i = -1; i <= 1; i++ )
			 	{
			 		float2 g = float2( i, j );
			 		float2 o = voronoihash3( n + g );
					o = ( sin( time + o * 6.2831 ) * 0.5 + 0.5 ); float2 r = f - g - o;
					float d = 0.5 * dot( r, r );
			 		if( d<F1 ) {
			 			F2 = F1;
			 			F1 = d; mg = g; mr = r; id = o;
			 		} else if( d<F2 ) {
			 			F2 = d;
			 		}
			 	}
			}
			return F1;
		}


		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			half2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			half time3 = 0.0;
			half2 center45_g1 = float2( 0.5,0.5 );
			half2 delta6_g1 = ( i.uv_texcoord - center45_g1 );
			half angle10_g1 = ( length( delta6_g1 ) * _Strenght );
			half x23_g1 = ( ( cos( angle10_g1 ) * delta6_g1.x ) - ( sin( angle10_g1 ) * delta6_g1.y ) );
			half2 break40_g1 = center45_g1;
			half2 temp_cast_0 = (( _Time.y * _Speed )).xx;
			half2 break41_g1 = temp_cast_0;
			half y35_g1 = ( ( sin( angle10_g1 ) * delta6_g1.x ) + ( cos( angle10_g1 ) * delta6_g1.y ) );
			half2 appendResult44_g1 = (half2(( x23_g1 + break40_g1.x + break41_g1.x ) , ( break40_g1.y + break41_g1.y + y35_g1 )));
			half2 coords3 = appendResult44_g1 * _Scale;
			half2 id3 = 0;
			half2 uv3 = 0;
			half voroi3 = voronoi3( coords3, time3, id3, uv3, 0 );
			half4 temp_output_17_0 = ( _Color0 * tex2D( _TextureSample0, uv_TextureSample0 ) * voroi3 );
			o.Emission = temp_output_17_0.rgb;
			o.Alpha = temp_output_17_0.r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}

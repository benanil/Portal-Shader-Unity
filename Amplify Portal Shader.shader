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
/*ASEBEGIN
Version=18800
0;73;1440;748;1428.246;354.3863;1.221178;False;False
Node;AmplifyShaderEditor.SimpleTimeNode;19;-1509.644,211.7114;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-1264.898,357.5904;Inherit;False;Property;_Speed;Speed;3;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1133.336,193.9809;Half;False;Property;_Strenght;Strenght;0;0;Create;True;0;0;0;False;0;False;21.36;19;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-1125.474,271.3117;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-696.1083,214.6681;Half;False;Property;_Scale;Scale;1;0;Create;True;0;0;0;False;0;False;2.39;3.35;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1;-947.0152,147.8267;Inherit;True;Twirl;-1;;1;90936742ac32db8449cd21ab6dd337c8;0;4;1;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;4;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;11;-983.7804,-73.51527;Inherit;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;0;False;0;False;-1;None;e2c8d1ea1af43d646bae32a7e770af66;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VoronoiNode;3;-558.3082,147.0681;Inherit;True;0;0;1;0;1;False;1;False;False;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;3;FLOAT;0;FLOAT2;1;FLOAT2;2
Node;AmplifyShaderEditor.ColorNode;16;-457.3397,-200.8467;Inherit;False;Property;_Color0;Color 0;2;1;[HDR];Create;True;0;0;0;False;0;False;0.3423572,1.261316,0.180188,0;2.239534,10.92456,0.7100961,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-229.4676,149.2019;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;15.79501,99.97133;Half;False;True;-1;0;ASEMaterialInspector;0;0;Unlit;Anil/Amplify Portal Shader;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;19;0
WireConnection;7;1;5;0
WireConnection;1;3;2;0
WireConnection;1;4;7;0
WireConnection;3;0;1;0
WireConnection;3;2;4;0
WireConnection;17;0;16;0
WireConnection;17;1;11;0
WireConnection;17;2;3;0
WireConnection;0;2;17;0
WireConnection;0;9;17;0
ASEEND*/
//CHKSM=3F8E6A78D4BA59B35AD0B2CAC57B58DE0ABECE99
// Made with Amplify Shader Editor v1.9.2
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "TerrainSpecial"
{
	Properties
	{
		_1Albedo("1Albedo", 2D) = "white" {}
		_1Specular("1Specular", 2D) = "white" {}
		_1Normal("1Normal", 2D) = "white" {}
		_1AO("1AO", 2D) = "white" {}
		_2Albedo("2Albedo", 2D) = "white" {}
		_2Specular("2Specular", 2D) = "white" {}
		_2Normal("2Normal", 2D) = "white" {}
		_2AO("2AO", 2D) = "white" {}
		_3Albedo("3Albedo", 2D) = "white" {}
		_3Specular("3Specular", 2D) = "white" {}
		_3Normal("3Normal", 2D) = "white" {}
		_3AO("3AO", 2D) = "white" {}
		_Metallic("Metallic", Float) = 1
		_Scale("Scale", Float) = 1
		_Scale2("Scale 2", Float) = 1
		_Offset("Offset", Float) = 0
		_Offset1("Offset", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _1Normal;
		uniform float4 _1Normal_ST;
		uniform sampler2D _2Normal;
		uniform float4 _2Normal_ST;
		uniform float _Scale;
		uniform float _Offset;
		uniform sampler2D _3Normal;
		uniform float4 _3Normal_ST;
		uniform float _Scale2;
		uniform float _Offset1;
		uniform sampler2D _1Albedo;
		uniform float4 _1Albedo_ST;
		uniform sampler2D _2Albedo;
		uniform float4 _2Albedo_ST;
		uniform sampler2D _3Albedo;
		uniform float4 _3Albedo_ST;
		uniform float _Metallic;
		uniform sampler2D _1Specular;
		uniform float4 _1Specular_ST;
		uniform sampler2D _2Specular;
		uniform float4 _2Specular_ST;
		uniform sampler2D _3Specular;
		uniform float4 _3Specular_ST;
		uniform sampler2D _1AO;
		uniform float4 _1AO_ST;
		uniform sampler2D _2AO;
		uniform float4 _2AO_ST;
		uniform sampler2D _3AO;
		uniform float4 _3AO_ST;


		void StochasticTiling( float2 UV, out float2 UV1, out float2 UV2, out float2 UV3, out float W1, out float W2, out float W3 )
		{
			float2 vertex1, vertex2, vertex3;
			// Scaling of the input
			float2 uv = UV * 3.464; // 2 * sqrt (3)
			// Skew input space into simplex triangle grid
			const float2x2 gridToSkewedGrid = float2x2( 1.0, 0.0, -0.57735027, 1.15470054 );
			float2 skewedCoord = mul( gridToSkewedGrid, uv );
			// Compute local triangle vertex IDs and local barycentric coordinates
			int2 baseId = int2( floor( skewedCoord ) );
			float3 temp = float3( frac( skewedCoord ), 0 );
			temp.z = 1.0 - temp.x - temp.y;
			if ( temp.z > 0.0 )
			{
				W1 = temp.z;
				W2 = temp.y;
				W3 = temp.x;
				vertex1 = baseId;
				vertex2 = baseId + int2( 0, 1 );
				vertex3 = baseId + int2( 1, 0 );
			}
			else
			{
				W1 = -temp.z;
				W2 = 1.0 - temp.y;
				W3 = 1.0 - temp.x;
				vertex1 = baseId + int2( 1, 1 );
				vertex2 = baseId + int2( 1, 0 );
				vertex3 = baseId + int2( 0, 1 );
			}
			UV1 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex1 ) ) * 43758.5453 );
			UV2 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex2 ) ) * 43758.5453 );
			UV3 = UV + frac( sin( mul( float2x2( 127.1, 311.7, 269.5, 183.3 ), vertex3 ) ) * 43758.5453 );
			return;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float localStochasticTiling2_g9 = ( 0.0 );
			float2 uv_1Normal = i.uv_texcoord * _1Normal_ST.xy + _1Normal_ST.zw;
			float2 Input_UV145_g9 = uv_1Normal;
			float2 UV2_g9 = Input_UV145_g9;
			float2 UV12_g9 = float2( 0,0 );
			float2 UV22_g9 = float2( 0,0 );
			float2 UV32_g9 = float2( 0,0 );
			float W12_g9 = 0.0;
			float W22_g9 = 0.0;
			float W32_g9 = 0.0;
			StochasticTiling( UV2_g9 , UV12_g9 , UV22_g9 , UV32_g9 , W12_g9 , W22_g9 , W32_g9 );
			float2 temp_output_10_0_g9 = ddx( Input_UV145_g9 );
			float2 temp_output_12_0_g9 = ddy( Input_UV145_g9 );
			float4 Output_2D293_g9 = ( ( tex2D( _1Normal, UV12_g9, temp_output_10_0_g9, temp_output_12_0_g9 ) * W12_g9 ) + ( tex2D( _1Normal, UV22_g9, temp_output_10_0_g9, temp_output_12_0_g9 ) * W22_g9 ) + ( tex2D( _1Normal, UV32_g9, temp_output_10_0_g9, temp_output_12_0_g9 ) * W32_g9 ) );
			float localStochasticTiling2_g10 = ( 0.0 );
			float2 uv_2Normal = i.uv_texcoord * _2Normal_ST.xy + _2Normal_ST.zw;
			float2 Input_UV145_g10 = uv_2Normal;
			float2 UV2_g10 = Input_UV145_g10;
			float2 UV12_g10 = float2( 0,0 );
			float2 UV22_g10 = float2( 0,0 );
			float2 UV32_g10 = float2( 0,0 );
			float W12_g10 = 0.0;
			float W22_g10 = 0.0;
			float W32_g10 = 0.0;
			StochasticTiling( UV2_g10 , UV12_g10 , UV22_g10 , UV32_g10 , W12_g10 , W22_g10 , W32_g10 );
			float2 temp_output_10_0_g10 = ddx( Input_UV145_g10 );
			float2 temp_output_12_0_g10 = ddy( Input_UV145_g10 );
			float4 Output_2D293_g10 = ( ( tex2D( _2Normal, UV12_g10, temp_output_10_0_g10, temp_output_12_0_g10 ) * W12_g10 ) + ( tex2D( _2Normal, UV22_g10, temp_output_10_0_g10, temp_output_12_0_g10 ) * W22_g10 ) + ( tex2D( _2Normal, UV32_g10, temp_output_10_0_g10, temp_output_12_0_g10 ) * W32_g10 ) );
			float3 ase_worldPos = i.worldPos;
			float4 transform23 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float temp_output_31_0 = saturate( ( ( ( float4( ase_worldPos , 0.0 ) - transform23 ) / ( _Scale * 2.0 ) ).y + _Offset ) );
			float4 lerpResult37 = lerp( Output_2D293_g9 , Output_2D293_g10 , temp_output_31_0);
			float localStochasticTiling2_g14 = ( 0.0 );
			float2 uv_3Normal = i.uv_texcoord * _3Normal_ST.xy + _3Normal_ST.zw;
			float2 Input_UV145_g14 = uv_3Normal;
			float2 UV2_g14 = Input_UV145_g14;
			float2 UV12_g14 = float2( 0,0 );
			float2 UV22_g14 = float2( 0,0 );
			float2 UV32_g14 = float2( 0,0 );
			float W12_g14 = 0.0;
			float W22_g14 = 0.0;
			float W32_g14 = 0.0;
			StochasticTiling( UV2_g14 , UV12_g14 , UV22_g14 , UV32_g14 , W12_g14 , W22_g14 , W32_g14 );
			float2 temp_output_10_0_g14 = ddx( Input_UV145_g14 );
			float2 temp_output_12_0_g14 = ddy( Input_UV145_g14 );
			float4 Output_2D293_g14 = ( ( tex2D( _3Normal, UV12_g14, temp_output_10_0_g14, temp_output_12_0_g14 ) * W12_g14 ) + ( tex2D( _3Normal, UV22_g14, temp_output_10_0_g14, temp_output_12_0_g14 ) * W22_g14 ) + ( tex2D( _3Normal, UV32_g14, temp_output_10_0_g14, temp_output_12_0_g14 ) * W32_g14 ) );
			float4 transform40 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float temp_output_48_0 = saturate( ( ( ( float4( ase_worldPos , 0.0 ) - transform40 ) / ( _Scale2 * 2.0 ) ).y + _Offset1 ) );
			float4 lerpResult57 = lerp( lerpResult37 , Output_2D293_g14 , temp_output_48_0);
			o.Normal = lerpResult57.rgb;
			float localStochasticTiling2_g11 = ( 0.0 );
			float2 uv_1Albedo = i.uv_texcoord * _1Albedo_ST.xy + _1Albedo_ST.zw;
			float2 Input_UV145_g11 = uv_1Albedo;
			float2 UV2_g11 = Input_UV145_g11;
			float2 UV12_g11 = float2( 0,0 );
			float2 UV22_g11 = float2( 0,0 );
			float2 UV32_g11 = float2( 0,0 );
			float W12_g11 = 0.0;
			float W22_g11 = 0.0;
			float W32_g11 = 0.0;
			StochasticTiling( UV2_g11 , UV12_g11 , UV22_g11 , UV32_g11 , W12_g11 , W22_g11 , W32_g11 );
			float2 temp_output_10_0_g11 = ddx( Input_UV145_g11 );
			float2 temp_output_12_0_g11 = ddy( Input_UV145_g11 );
			float4 Output_2D293_g11 = ( ( tex2D( _1Albedo, UV12_g11, temp_output_10_0_g11, temp_output_12_0_g11 ) * W12_g11 ) + ( tex2D( _1Albedo, UV22_g11, temp_output_10_0_g11, temp_output_12_0_g11 ) * W22_g11 ) + ( tex2D( _1Albedo, UV32_g11, temp_output_10_0_g11, temp_output_12_0_g11 ) * W32_g11 ) );
			float localStochasticTiling2_g6 = ( 0.0 );
			float2 uv_2Albedo = i.uv_texcoord * _2Albedo_ST.xy + _2Albedo_ST.zw;
			float2 Input_UV145_g6 = uv_2Albedo;
			float2 UV2_g6 = Input_UV145_g6;
			float2 UV12_g6 = float2( 0,0 );
			float2 UV22_g6 = float2( 0,0 );
			float2 UV32_g6 = float2( 0,0 );
			float W12_g6 = 0.0;
			float W22_g6 = 0.0;
			float W32_g6 = 0.0;
			StochasticTiling( UV2_g6 , UV12_g6 , UV22_g6 , UV32_g6 , W12_g6 , W22_g6 , W32_g6 );
			float2 temp_output_10_0_g6 = ddx( Input_UV145_g6 );
			float2 temp_output_12_0_g6 = ddy( Input_UV145_g6 );
			float4 Output_2D293_g6 = ( ( tex2D( _2Albedo, UV12_g6, temp_output_10_0_g6, temp_output_12_0_g6 ) * W12_g6 ) + ( tex2D( _2Albedo, UV22_g6, temp_output_10_0_g6, temp_output_12_0_g6 ) * W22_g6 ) + ( tex2D( _2Albedo, UV32_g6, temp_output_10_0_g6, temp_output_12_0_g6 ) * W32_g6 ) );
			float4 lerpResult18 = lerp( Output_2D293_g11 , Output_2D293_g6 , temp_output_31_0);
			float localStochasticTiling2_g12 = ( 0.0 );
			float2 uv_3Albedo = i.uv_texcoord * _3Albedo_ST.xy + _3Albedo_ST.zw;
			float2 Input_UV145_g12 = uv_3Albedo;
			float2 UV2_g12 = Input_UV145_g12;
			float2 UV12_g12 = float2( 0,0 );
			float2 UV22_g12 = float2( 0,0 );
			float2 UV32_g12 = float2( 0,0 );
			float W12_g12 = 0.0;
			float W22_g12 = 0.0;
			float W32_g12 = 0.0;
			StochasticTiling( UV2_g12 , UV12_g12 , UV22_g12 , UV32_g12 , W12_g12 , W22_g12 , W32_g12 );
			float2 temp_output_10_0_g12 = ddx( Input_UV145_g12 );
			float2 temp_output_12_0_g12 = ddy( Input_UV145_g12 );
			float4 Output_2D293_g12 = ( ( tex2D( _3Albedo, UV12_g12, temp_output_10_0_g12, temp_output_12_0_g12 ) * W12_g12 ) + ( tex2D( _3Albedo, UV22_g12, temp_output_10_0_g12, temp_output_12_0_g12 ) * W22_g12 ) + ( tex2D( _3Albedo, UV32_g12, temp_output_10_0_g12, temp_output_12_0_g12 ) * W32_g12 ) );
			float4 lerpResult49 = lerp( lerpResult18 , Output_2D293_g12 , temp_output_48_0);
			o.Albedo = lerpResult49.rgb;
			o.Metallic = _Metallic;
			float localStochasticTiling2_g16 = ( 0.0 );
			float2 uv_1Specular = i.uv_texcoord * _1Specular_ST.xy + _1Specular_ST.zw;
			float2 Input_UV145_g16 = uv_1Specular;
			float2 UV2_g16 = Input_UV145_g16;
			float2 UV12_g16 = float2( 0,0 );
			float2 UV22_g16 = float2( 0,0 );
			float2 UV32_g16 = float2( 0,0 );
			float W12_g16 = 0.0;
			float W22_g16 = 0.0;
			float W32_g16 = 0.0;
			StochasticTiling( UV2_g16 , UV12_g16 , UV22_g16 , UV32_g16 , W12_g16 , W22_g16 , W32_g16 );
			float2 temp_output_10_0_g16 = ddx( Input_UV145_g16 );
			float2 temp_output_12_0_g16 = ddy( Input_UV145_g16 );
			float4 Output_2D293_g16 = ( ( tex2D( _1Specular, UV12_g16, temp_output_10_0_g16, temp_output_12_0_g16 ) * W12_g16 ) + ( tex2D( _1Specular, UV22_g16, temp_output_10_0_g16, temp_output_12_0_g16 ) * W22_g16 ) + ( tex2D( _1Specular, UV32_g16, temp_output_10_0_g16, temp_output_12_0_g16 ) * W32_g16 ) );
			float localStochasticTiling2_g17 = ( 0.0 );
			float2 uv_2Specular = i.uv_texcoord * _2Specular_ST.xy + _2Specular_ST.zw;
			float2 Input_UV145_g17 = uv_2Specular;
			float2 UV2_g17 = Input_UV145_g17;
			float2 UV12_g17 = float2( 0,0 );
			float2 UV22_g17 = float2( 0,0 );
			float2 UV32_g17 = float2( 0,0 );
			float W12_g17 = 0.0;
			float W22_g17 = 0.0;
			float W32_g17 = 0.0;
			StochasticTiling( UV2_g17 , UV12_g17 , UV22_g17 , UV32_g17 , W12_g17 , W22_g17 , W32_g17 );
			float2 temp_output_10_0_g17 = ddx( Input_UV145_g17 );
			float2 temp_output_12_0_g17 = ddy( Input_UV145_g17 );
			float4 Output_2D293_g17 = ( ( tex2D( _2Specular, UV12_g17, temp_output_10_0_g17, temp_output_12_0_g17 ) * W12_g17 ) + ( tex2D( _2Specular, UV22_g17, temp_output_10_0_g17, temp_output_12_0_g17 ) * W22_g17 ) + ( tex2D( _2Specular, UV32_g17, temp_output_10_0_g17, temp_output_12_0_g17 ) * W32_g17 ) );
			float4 lerpResult66 = lerp( Output_2D293_g16 , Output_2D293_g17 , float4( 0,0,0,0 ));
			float localStochasticTiling2_g15 = ( 0.0 );
			float2 uv_3Specular = i.uv_texcoord * _3Specular_ST.xy + _3Specular_ST.zw;
			float2 Input_UV145_g15 = uv_3Specular;
			float2 UV2_g15 = Input_UV145_g15;
			float2 UV12_g15 = float2( 0,0 );
			float2 UV22_g15 = float2( 0,0 );
			float2 UV32_g15 = float2( 0,0 );
			float W12_g15 = 0.0;
			float W22_g15 = 0.0;
			float W32_g15 = 0.0;
			StochasticTiling( UV2_g15 , UV12_g15 , UV22_g15 , UV32_g15 , W12_g15 , W22_g15 , W32_g15 );
			float2 temp_output_10_0_g15 = ddx( Input_UV145_g15 );
			float2 temp_output_12_0_g15 = ddy( Input_UV145_g15 );
			float4 Output_2D293_g15 = ( ( tex2D( _3Specular, UV12_g15, temp_output_10_0_g15, temp_output_12_0_g15 ) * W12_g15 ) + ( tex2D( _3Specular, UV22_g15, temp_output_10_0_g15, temp_output_12_0_g15 ) * W22_g15 ) + ( tex2D( _3Specular, UV32_g15, temp_output_10_0_g15, temp_output_12_0_g15 ) * W32_g15 ) );
			float4 lerpResult58 = lerp( lerpResult66 , Output_2D293_g15 , temp_output_48_0);
			o.Smoothness = lerpResult58.r;
			float localStochasticTiling2_g7 = ( 0.0 );
			float2 uv_1AO = i.uv_texcoord * _1AO_ST.xy + _1AO_ST.zw;
			float2 Input_UV145_g7 = uv_1AO;
			float2 UV2_g7 = Input_UV145_g7;
			float2 UV12_g7 = float2( 0,0 );
			float2 UV22_g7 = float2( 0,0 );
			float2 UV32_g7 = float2( 0,0 );
			float W12_g7 = 0.0;
			float W22_g7 = 0.0;
			float W32_g7 = 0.0;
			StochasticTiling( UV2_g7 , UV12_g7 , UV22_g7 , UV32_g7 , W12_g7 , W22_g7 , W32_g7 );
			float2 temp_output_10_0_g7 = ddx( Input_UV145_g7 );
			float2 temp_output_12_0_g7 = ddy( Input_UV145_g7 );
			float4 Output_2D293_g7 = ( ( tex2D( _1AO, UV12_g7, temp_output_10_0_g7, temp_output_12_0_g7 ) * W12_g7 ) + ( tex2D( _1AO, UV22_g7, temp_output_10_0_g7, temp_output_12_0_g7 ) * W22_g7 ) + ( tex2D( _1AO, UV32_g7, temp_output_10_0_g7, temp_output_12_0_g7 ) * W32_g7 ) );
			float localStochasticTiling2_g8 = ( 0.0 );
			float2 uv_2AO = i.uv_texcoord * _2AO_ST.xy + _2AO_ST.zw;
			float2 Input_UV145_g8 = uv_2AO;
			float2 UV2_g8 = Input_UV145_g8;
			float2 UV12_g8 = float2( 0,0 );
			float2 UV22_g8 = float2( 0,0 );
			float2 UV32_g8 = float2( 0,0 );
			float W12_g8 = 0.0;
			float W22_g8 = 0.0;
			float W32_g8 = 0.0;
			StochasticTiling( UV2_g8 , UV12_g8 , UV22_g8 , UV32_g8 , W12_g8 , W22_g8 , W32_g8 );
			float2 temp_output_10_0_g8 = ddx( Input_UV145_g8 );
			float2 temp_output_12_0_g8 = ddy( Input_UV145_g8 );
			float4 Output_2D293_g8 = ( ( tex2D( _2AO, UV12_g8, temp_output_10_0_g8, temp_output_12_0_g8 ) * W12_g8 ) + ( tex2D( _2AO, UV22_g8, temp_output_10_0_g8, temp_output_12_0_g8 ) * W22_g8 ) + ( tex2D( _2AO, UV32_g8, temp_output_10_0_g8, temp_output_12_0_g8 ) * W32_g8 ) );
			float4 lerpResult36 = lerp( Output_2D293_g7 , Output_2D293_g8 , temp_output_31_0);
			float localStochasticTiling2_g13 = ( 0.0 );
			float2 uv_3AO = i.uv_texcoord * _3AO_ST.xy + _3AO_ST.zw;
			float2 Input_UV145_g13 = uv_3AO;
			float2 UV2_g13 = Input_UV145_g13;
			float2 UV12_g13 = float2( 0,0 );
			float2 UV22_g13 = float2( 0,0 );
			float2 UV32_g13 = float2( 0,0 );
			float W12_g13 = 0.0;
			float W22_g13 = 0.0;
			float W32_g13 = 0.0;
			StochasticTiling( UV2_g13 , UV12_g13 , UV22_g13 , UV32_g13 , W12_g13 , W22_g13 , W32_g13 );
			float2 temp_output_10_0_g13 = ddx( Input_UV145_g13 );
			float2 temp_output_12_0_g13 = ddy( Input_UV145_g13 );
			float4 Output_2D293_g13 = ( ( tex2D( _3AO, UV12_g13, temp_output_10_0_g13, temp_output_12_0_g13 ) * W12_g13 ) + ( tex2D( _3AO, UV22_g13, temp_output_10_0_g13, temp_output_12_0_g13 ) * W22_g13 ) + ( tex2D( _3AO, UV32_g13, temp_output_10_0_g13, temp_output_12_0_g13 ) * W32_g13 ) );
			float4 lerpResult56 = lerp( lerpResult36 , Output_2D293_g13 , temp_output_48_0);
			o.Occlusion = lerpResult56.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19200
Node;AmplifyShaderEditor.FunctionNode;19;-1713.533,-462.9899;Inherit;False;Procedural Sample;-1;;6;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.FunctionNode;16;-1750.484,-156.3982;Inherit;False;Procedural Sample;-1;;7;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.FunctionNode;32;-1745.86,43.74799;Inherit;False;Procedural Sample;-1;;8;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.FunctionNode;15;-1742.792,409.8006;Inherit;False;Procedural Sample;-1;;9;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.FunctionNode;34;-1744.619,620.0886;Inherit;False;Procedural Sample;-1;;10;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.LerpOp;36;-1324.649,-147.9501;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WorldPosInputsNode;21;-2837.707,-1295.268;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;22;-2574.071,-1138.012;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;23;-2834.624,-1080.968;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-2372.104,-980.754;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-2584.864,-897.5004;Inherit;False;Constant;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;27;-2213.304,-1130.303;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;28;-2068.382,-1127.219;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-1843.287,-1125.677;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-2077.633,-943.7518;Inherit;False;Property;_Offset;Offset;15;0;Create;True;0;0;0;False;0;False;0;-33.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;31;-1682.947,-1125.677;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;18;-1275.722,-647.9157;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;12;-1719.647,-678.8093;Inherit;False;Procedural Sample;-1;;11;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.TexturePropertyNode;13;-2069.191,-750.7274;Inherit;True;Property;_1Albedo;1Albedo;0;0;Create;True;0;0;0;False;0;False;None;d77018300cd987341ad80dcdce4677c1;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;20;-1988.774,-500.99;Inherit;True;Property;_2Albedo;2Albedo;4;0;Create;True;0;0;0;False;0;False;None;967fbdc1f746cf34e8d3dd18bcd56d52;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;17;-2024.484,-162.3982;Inherit;True;Property;_1AO;1AO;3;0;Create;True;0;0;0;False;0;False;None;68cdb00201db6734bb17b40d13532d77;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;33;-2065.36,37.74799;Inherit;True;Property;_2AO;2AO;7;0;Create;True;0;0;0;False;0;False;None;1b458156b40c09743b8d3a3c6bdb7e9f;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;14;-2061.602,373.2956;Inherit;True;Property;_1Normal;1Normal;2;0;Create;True;0;0;0;False;0;False;None;e7386fef8f846b743a3258d9241e1489;True;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;35;-2071.229,600.4836;Inherit;True;Property;_2Normal;2Normal;6;0;Create;True;0;0;0;False;0;False;None;ed9c81acc21233e428c456d4b5f2eb2a;True;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1055.436,-350.5848;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;TerrainSpecial;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;True;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.WorldPosInputsNode;38;-2129.063,-2100.307;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;39;-1865.427,-1943.051;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;40;-2125.98,-1886.007;Inherit;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1663.46,-1785.793;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-1876.22,-1702.539;Inherit;False;Constant;_Float1;Float 0;5;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;44;-1504.66,-1935.342;Inherit;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.BreakToComponentsNode;45;-1359.738,-1932.258;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-1134.643,-1930.716;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1368.989,-1748.791;Inherit;False;Property;_Offset1;Offset;16;0;Create;True;0;0;0;False;0;False;0;-26.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;48;-974.3036,-1930.716;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1876.219,-1790.418;Inherit;False;Property;_Scale2;Scale 2;14;0;Create;True;0;0;0;False;0;False;1;1.78;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;51;-906.4311,-1443.696;Inherit;False;Procedural Sample;-1;;12;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.FunctionNode;53;-902.9296,-1202.121;Inherit;False;Procedural Sample;-1;;13;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.LerpOp;49;-331.5708,-1304.09;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;56;-262.9295,-1081.771;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;50;-1255.974,-1515.614;Inherit;True;Property;_3Albedo;3Albedo;8;0;Create;True;0;0;0;False;0;False;None;d1b0c5c994c51114ebc4c7e0bfbd62f0;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;52;-1252.473,-1274.039;Inherit;True;Property;_3AO;3AO;11;0;Create;True;0;0;0;False;0;False;None;5c221af358a7f934d8fd4ab09a85aeee;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.LerpOp;57;-187.4958,-824.7379;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;58;-183.7306,-589.2847;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;54;-1259.475,-1053.47;Inherit;True;Property;_3Normal;3Normal;10;0;Create;True;0;0;0;False;0;False;None;37929c139a7a6bf48b07c14bdf56e509;True;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;55;-909.9318,-981.5523;Inherit;False;Procedural Sample;-1;;14;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.TexturePropertyNode;60;-1242.15,-828.2866;Inherit;True;Property;_3Specular;3Specular;9;0;Create;True;0;0;0;False;0;False;None;be0c7b0bbd13dcc4783f095ff4514165;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;61;-892.607,-756.3688;Inherit;False;Procedural Sample;-1;;15;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.FunctionNode;63;-1738.11,970.3008;Inherit;False;Procedural Sample;-1;;16;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.FunctionNode;65;-1741.431,1186.109;Inherit;False;Procedural Sample;-1;;17;f5379ff72769e2b4495e5ce2f004d8d4;2,157,0,315,0;7;82;SAMPLER2D;0;False;158;SAMPLER2DARRAY;0;False;183;FLOAT;0;False;5;FLOAT2;0,0;False;80;FLOAT3;0,0,0;False;104;FLOAT2;1,1;False;74;SAMPLERSTATE;0;False;5;COLOR;0;FLOAT;32;FLOAT;33;FLOAT;34;FLOAT;35
Node;AmplifyShaderEditor.TexturePropertyNode;62;-2087.653,898.3829;Inherit;True;Property;_1Specular;1Specular;1;0;Create;True;0;0;0;False;0;False;None;30edcbc016022e242890f72b4b3241f5;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;64;-2090.974,1114.191;Inherit;True;Property;_2Specular;2Specular;5;0;Create;True;0;0;0;False;0;False;None;52f88a59b512e8648803c95ec9b621bf;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.LerpOp;37;-1334.819,429.6351;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;66;-1406.853,1078.757;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-2584.863,-985.3793;Inherit;False;Property;_Scale;Scale;13;0;Create;True;0;0;0;False;0;False;1;1.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;861.546,-175.2411;Inherit;False;Property;_Metallic;Metallic;12;0;Create;True;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
WireConnection;19;82;20;0
WireConnection;16;82;17;0
WireConnection;32;82;33;0
WireConnection;15;82;14;0
WireConnection;34;82;35;0
WireConnection;36;0;16;0
WireConnection;36;1;32;0
WireConnection;36;2;31;0
WireConnection;22;0;21;0
WireConnection;22;1;23;0
WireConnection;25;0;24;0
WireConnection;25;1;26;0
WireConnection;27;0;22;0
WireConnection;27;1;25;0
WireConnection;28;0;27;0
WireConnection;29;0;28;1
WireConnection;29;1;30;0
WireConnection;31;0;29;0
WireConnection;18;0;12;0
WireConnection;18;1;19;0
WireConnection;18;2;31;0
WireConnection;12;82;13;0
WireConnection;0;0;49;0
WireConnection;0;1;57;0
WireConnection;0;3;67;0
WireConnection;0;4;58;0
WireConnection;0;5;56;0
WireConnection;39;0;38;0
WireConnection;39;1;40;0
WireConnection;42;0;41;0
WireConnection;42;1;43;0
WireConnection;44;0;39;0
WireConnection;44;1;42;0
WireConnection;45;0;44;0
WireConnection;46;0;45;1
WireConnection;46;1;47;0
WireConnection;48;0;46;0
WireConnection;51;82;50;0
WireConnection;53;82;52;0
WireConnection;49;0;18;0
WireConnection;49;1;51;0
WireConnection;49;2;48;0
WireConnection;56;0;36;0
WireConnection;56;1;53;0
WireConnection;56;2;48;0
WireConnection;57;0;37;0
WireConnection;57;1;55;0
WireConnection;57;2;48;0
WireConnection;58;0;66;0
WireConnection;58;1;61;0
WireConnection;58;2;48;0
WireConnection;55;82;54;0
WireConnection;61;82;60;0
WireConnection;63;82;62;0
WireConnection;65;82;64;0
WireConnection;37;0;15;0
WireConnection;37;1;34;0
WireConnection;37;2;31;0
WireConnection;66;0;63;0
WireConnection;66;1;65;0
ASEEND*/
//CHKSM=73AE6287A86E3B55C83AC54C08BD9255AFACF2F9
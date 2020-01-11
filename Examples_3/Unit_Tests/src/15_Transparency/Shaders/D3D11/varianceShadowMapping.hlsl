/*
* Copyright (c) 2018-2019 Confetti Interactive Inc.
*
* This file is part of The-Forge
* (see https://github.com/ConfettiFX/The-Forge).
*
* Licensed to the Apache Software Foundation (ASF) under one
* or more contributor license agreements.  See the NOTICE file
* distributed with this work for additional information
* regarding copyright ownership.  The ASF licenses this file
* to you under the Apache License, Version 2.0 (the
* "License"); you may not use this file except in compliance
* with the License.  You may obtain a copy of the License at
*
*   http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing,
* software distributed under the License is distributed on an
* "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
* KIND, either express or implied.  See the License for the
* specific language governing permissions and limitations
* under the License.
*
* Reference:
* https://developer.nvidia.com/gpugems/GPUGems3/gpugems3_ch08.html
*/

Texture2D VSM : register(t9);
SamplerState VSMSampler : register(s9);
#if PT_USE_CAUSTICS != 0
Texture2D VSMRed : register(t10);
Texture2D VSMGreen : register(t11);
Texture2D VSMBlue : register(t12);
#endif

float2 ComputeMoments(float depth)
{
	float2 moments;
	moments.x = depth;
	float2 pd = float2(ddx(depth), ddy(depth));
	moments.y = depth * depth + 0.25f * dot(pd, pd);
	return moments;
}

float ChebyshevUpperBound(float2 moments, float t)
{
	float p = t <= moments.x;
	float variance = moments.y - (moments.x * moments.x);
	variance = max(variance, 0.001f);
	float d = t - moments.x;
	float pMax = variance / (variance + d * d);
	return max(p, pMax);
}

float3 ShadowContribution(float2 shadowMapPos, float distanceToLight)
{
	float2 moments = VSM.Sample(VSMSampler, shadowMapPos).xy;
	float3 shadow = ChebyshevUpperBound(moments, distanceToLight);

#if PT_USE_CAUSTICS != 0
	moments = VSMRed.Sample(VSMSampler, shadowMapPos).xy;
	shadow.r *= ChebyshevUpperBound(moments, distanceToLight);
	moments = VSMGreen.Sample(VSMSampler, shadowMapPos).xy;
	shadow.g *= ChebyshevUpperBound(moments, distanceToLight);
	moments = VSMBlue.Sample(VSMSampler, shadowMapPos).xy;
	shadow.b *= ChebyshevUpperBound(moments, distanceToLight);
#endif

	return shadow;
}
#version 450 core

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
*/


layout (location = 0) in float textcoord;

layout (location = 0) out vec4 oColor;

layout (UPDATE_FREQ_NONE, binding=11) uniform texture1D uTex0[5];
layout (UPDATE_FREQ_NONE, binding=3) uniform sampler uSampler0;

layout(push_constant) uniform pushConstantBlock
{
    uniform float paletteFactor;
    uniform uint data;
	uniform uint textureIndex;
} particleRootConstant;

void main( void )
{
  vec4 ca = texture(sampler1D(uTex0[particleRootConstant.textureIndex], uSampler0), textcoord);
  vec4 cb = texture(sampler1D(uTex0[(particleRootConstant.textureIndex + 1) % 5], uSampler0), textcoord);
  oColor =  0.05f * mix(ca, cb, particleRootConstant.paletteFactor);
}

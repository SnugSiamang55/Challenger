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

#version 150
#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (UPDATE_FREQ_PER_FRAME, binding=0) uniform uniformBlock
{
	uniform mat4 viewProject;
};

layout(push_constant) uniform pushConstantBlock
{
    uniform float paletteFactor;
    uniform uint data;
	uniform uint textureIndex;
} particleRootConstant;

layout (location = 0) in uint seed;

layout (location = 0) out float textcoord;
void main( void )
{
    uint rnd = seed;
    uint rnd_mat = particleRootConstant.data;
    float tt = particleRootConstant.paletteFactor;

    
    vec4 p;
    float c = 0.0f;
    
     rnd = rnd * 196314165u + 907633515u;
  p.x = float(rnd) * 2.3283064365387e-10;
  rnd = rnd * 196314165u + 907633515u;
  p.y = float(rnd) * 2.3283064365387e-10;
  rnd = rnd * 196314165u + 907633515u;
  p.z = float(rnd) * 2.3283064365387e-10;
  p.w = 1.0;

  vec3 t0, s0, r0, t1, s1, r1;

  // translation 0
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  t0.x = -1.3 + 2.6 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  t0.y = -1.3 + 2.6 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  t0.z = -1.3 + 2.6 * float(rnd_mat) * 2.3283064365387e-10;

  // scaling 0
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  s0.x = 0.8 + 0.2 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  s0.y = 0.8 + 0.2 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  s0.z = 0.8 + 0.2 * float(rnd_mat) * 2.3283064365387e-10;

  // rotation 0
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  r0.x = 1.57079632679 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  r0.y = 1.57079632679 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  r0.z = 1.57079632679 * float(rnd_mat) * 2.3283064365387e-10;

  // translation 1
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  t1.x = -1.3 + 2.6 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  t1.y = -1.3 + 2.6 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  t1.z = -1.3 + 2.6 * float(rnd_mat) * 2.3283064365387e-10;

  // scaling 1
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  s1.x = 0.8 + 0.2 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  s1.y = 0.8 + 0.2 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  s1.z = 0.8 + 0.2 * float(rnd_mat) * 2.3283064365387e-10;

  // rotation 1
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  r1.x = 1.57079632679 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  r1.y = 1.57079632679 * float(rnd_mat) * 2.3283064365387e-10;
  rnd_mat = rnd_mat * 196314165u + 907633515u;
  r1.z = 1.57079632679 * float(rnd_mat) * 2.3283064365387e-10;

  float tmp0_ch = cos(r0.x);
  float tmp0_sh = sin(r0.x);
  float tmp0_cp = cos(r0.y);
  float tmp0_sp = sin(r0.y);
  float tmp0_cb = cos(r0.z);
  float tmp0_sb = sin(r0.z);

  float tmp1_ch = cos(r1.x);
  float tmp1_sh = sin(r1.x);
  float tmp1_cp = cos(r1.y);
  float tmp1_sp = sin(r1.y);
  float tmp1_cb = cos(r1.z);
  float tmp1_sb = sin(r1.z);

  float tt0 = 1.0 - tt;

  mat4 transform;
  transform[0][0] = (tmp0_ch * tmp0_cb + tmp0_sh * tmp0_sp * tmp0_sb * s0.x) * tt0 + (tmp1_ch * tmp1_cb + tmp1_sh * tmp1_sp * tmp1_sb * s1.x) * tt;
  transform[0][1] = (tmp0_sb * tmp0_cp) * tt0 + (tmp1_sb * tmp1_cp) * tt;
  transform[0][2] = (-tmp0_sh * tmp0_cb + tmp0_ch * tmp0_sp * tmp0_sb) * tt0 + (-tmp1_sh * tmp1_cb + tmp1_ch * tmp1_sp * tmp1_sb) * tt;
  transform[0][3] = 0.0;
  transform[1][0] = (-tmp0_ch * tmp0_sb + tmp0_sh * tmp0_sp * tmp0_cb) * tt0 + (-tmp1_ch * tmp1_sb + tmp1_sh * tmp1_sp * tmp1_cb) * tt;
  transform[1][1] = (tmp0_cb * tmp0_cp * s0.y) * tt0 + (tmp1_cb * tmp1_cp * s1.y) * tt;
  transform[1][2] = (tmp0_sb * tmp0_sh + tmp0_ch * tmp0_sp * tmp0_cb) * tt0 + (tmp1_sb * tmp1_sh + tmp1_ch * tmp1_sp * tmp1_cb) * tt;
  transform[1][3] = 0.0;
  transform[2][0] = (tmp0_sh * tmp0_cp) * tt0 + (tmp1_sh * tmp1_cp) * tt;
  transform[2][1] = (-tmp0_sp) * tt0 + (-tmp1_sp) * tt;
  transform[2][2] = (tmp0_ch * tmp0_cp * s0.z) * tt0 + (tmp1_ch * tmp1_cp * s1.z) * tt;
  transform[2][3] = 0.0;
  transform[3][0] = t0.x * tt0 + t1.x * tt;
  transform[3][1] = t0.y * tt0 + t1.y * tt;
  transform[3][2] = t0.z * tt0 + t1.z * tt;
  transform[3][3] = 1.0;

  for (int i = 0; i < 8; ++i)
  {
    p = transform * p;
    float radius = length(p);
    float theta = p.y * (1.0 / p.x);
    p = vec4(radius * cos(theta - radius), radius * sin(theta - radius), p.z, p.w);
    c += 0.1 * sin(theta);
  }

    gl_Position = viewProject * p;
	gl_PointSize = 1.0;
    textcoord = c;
}

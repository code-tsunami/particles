typedef float4 point;
typedef float4 vector;
typedef float4 color;
typedef float4 sphere;
typedef float4 rgba;

vector ColorParticle(vector in)
{
	// color particle based on position
	float r = (3.2404542 * in.x - 1.5371385 * in.y - 0.4985314 * in.z) / 255;
	float g = (-0.9692660 * in.x + 1.8760108 * in.y + 0.0415560 * in.z) / 255;
	float b = ( 0.0556434 * in.x - 0.2040259 * in.y + 1.0572252 * in.z) / 255;
    float a = 1.f;
    // determine dist from origin
    point centerInnerSphere = (vector)(0, -1400., 0, 0);
    float dist = distance(in, centerInnerSphere);
    // adjust color based on how far vector in is from centerInnerSphere
    // this could be played with more
    if(dist > 50) b = .5;
    if(dist > 70) b = .7;
    if(dist > 90) b = .9;
    return (rgba)(r, g, b, a);
}

vector Bounce( vector in, vector n )
{
	// don't bounce it as much so it doesn't continue bouncing - eventually stops
	vector out = (vector)0.9 * (in - n*(vector)( 2. * dot(in.xyz, n.xyz) ));
	out.w = 0.;
	return out;
}

vector BounceSphere( point p, vector v, sphere s )
{
	vector n;
	n.xyz = fast_normalize( p.xyz - s.xyz );
	n.w = 0.;
	return Bounce( v, n );
}

bool IsInsideSphere( point p, sphere s )
{
	float r = fast_length( p.xyz - s.xyz );
	return  ( r < s.w );
}

kernel void Particle( global point* dPobj, global vector* dVel, global color* dCobj )
{
	const float4 G       = (float4) ( 0., -9.8, 0., 0. );
	const float  DT      = 0.1;
	// inside (smaller) sphere
	const sphere Sphere1 = (sphere)( 0., -1400., 0.,  600. );
	// container (larger) sphere
	const sphere Sphere2 = (sphere)( 0., 0., 0.,  2000. );
	int gid = get_global_id( 0 );

	point  p = dPobj[gid];
	vector v = dVel[gid];

	point  pp = p + v*DT + G*(point)( .5*DT*DT );
	vector vp = v + G*DT;
	pp.w = 1.;
	vp.w = 0.;

	if( IsInsideSphere( pp, Sphere1 ) )
	{
		vp = BounceSphere( p, v, Sphere1 );
		pp = p + vp*DT + G*(point)( .5*DT*DT );
	}

	if( !IsInsideSphere( pp, Sphere2 ) )
	{
		vp = BounceSphere( p, v, Sphere2 );
		pp = p + vp*DT + G*(point)( .5*DT*DT );
	}

	// update particle's position
	dPobj[gid] = pp;
	// update particle's velocity
	dVel[gid]  = vp;

	// update particle color based on its position
	dCobj[gid] = ColorParticle(pp);
}

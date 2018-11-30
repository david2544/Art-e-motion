class Attractor{
	Particle2 particle;
	float mass;
	PVector location;
	float g;
	float strength;
	float distance;

	Attractor(PVector position){
		location = position.get();
		mass = random(20); // later one try with depthvalue
		g = 5;
	}

	PVector attract(Particle2 particle){
		PVector force = PVector.sub(location, particle.position);
		distance = force.mag();
		force.normalize();
		strength = g / distance * distance;
		force.mult(strength);
    colour.update();
		
		return force;
	}

}
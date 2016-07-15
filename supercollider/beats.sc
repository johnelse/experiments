s.boot

SynthDef(\beats, {
	arg f0, f1;
	var out0, out1;

	out0 = SinOsc.ar(f0);
	out1 = SinOsc.ar(f1);

	Out.ar(0, [out0, out1])
}).send(s)

Synth.new(\beats, [\f0, 200, \f1, 204])

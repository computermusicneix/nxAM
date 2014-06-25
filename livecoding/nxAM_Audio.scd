
// nxAM_Audio

~b.play;

(
~b = { arg vol, t_trig, release, reldiv;
	Pan2.ar(
		RLPF.ar(
			PlayBuf.ar(1,a,0.4,1,0,1), 2000, 1,10)
		* EnvGen.kr(Env.perc(0.001,release, vol*40),t_trig)
			,-1)
}
)

~c.play;

(
~c = { arg vol, t_trig, release, reldiv;
	Pan2.ar(
		RHPF.ar(
			PlayBuf.ar(1,a,1,1,0,1), 8000, 1,10)
		* EnvGen.kr(Env.perc(0.001,release, vol*200),t_trig)
			,1)
}
)

~d.play;


(
~d = { arg vol, t_trig, release, reldiv, freq, delay = 1;
	Pan2.ar(
	    RLPF.ar(RHPF.ar(
		CombC.ar(
		PlayBuf.ar(1,a,freq/1000,1,0,1) + SinOsc.ar(freq,0,1)
		+ SinOsc.ar(freq/2,0,8) + SinOsc.ar(freq*10,0,10)
			,0.2,0.2,delay),
			freq,0.1,1),freq/10,0.9,100) * EnvGen.kr(Env.perc(0.1,1, vol/25),t_trig)
		,0)
}
)

~e.play;

(
~e = { arg vol, t_trig, release, reldiv, freq;
	Pan2.ar(
		RLPF.ar(PlayBuf.ar(1,a,freq/100,Impulse.kr(rrand(10,33)),0,1),freq*2,0.9) * (vol*10)
			,0)
}
)

Tdef(\d).pause;
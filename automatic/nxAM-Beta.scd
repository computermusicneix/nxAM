
// nxAM-Beta

(
Tdef(\x, {
p = ProxySpace.push();
0.3.wait;
j = Platform.userHomeDir +/+ ".local/share/SuperCollider/nxAMFull/application.linux32/nxAMFull";
0.3.wait;
j.unixCmd;
5.wait;
m = NetAddr.new("127.0.0.1", 12000);
0.3.wait;
t = Date.getDate.format("nxAM-Beta"++"-%Y-%m-%d_%H_%M_%S").postln;
0.3.wait;
m.sendMsg("/title", t ++ " / Miquel Parera");
0.3.wait;
a = Buffer.alloc(s, 44100 * 0.01, 2);
0.3.wait;
~a.play;
0.3.wait;
~a.vol = 0;
0.3.wait;
~a = { Limiter.ar(RecordBuf.ar(SoundIn.ar([0,1]),a, doneAction:2, loop:0),1) };
0.3.wait;
~b.play;
0.3.wait;
(
~b = { arg vol, t_trig, release, reldiv;
	Pan2.ar(
		RLPF.ar(
			PlayBuf.ar(1,a,0.4,1,0,1), 2000, 1,10)
		* EnvGen.kr(Env.perc(0.001,release, vol*40),t_trig)
			,-1)
}
);
0.3.wait;
~c.play;
0.3.wait;
(
~c = { arg vol, t_trig, release, reldiv;
	Pan2.ar(
		RHPF.ar(
			PlayBuf.ar(1,a,1,1,0,1), 8000, 1,10)
		* EnvGen.kr(Env.perc(0.001,release, vol*200),t_trig)
			,1)
}
);
0.3.wait;
~d.play;
0.3.wait;
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
);
0.3.wait;
~e.play;
0.3.wait;
(
~e = { arg vol, t_trig, release, reldiv, freq;
	Pan2.ar(
		RLPF.ar(PlayBuf.ar(1,a,freq/100,Impulse.kr(rrand(10,33)),0,1),freq*2,0.9) * (vol*10)
			,0)
}
);
0.3.wait;
b = rrand(0.2,0.4);
0.3.wait;
c = [b/8,b/4,b/2,b,b*2,b*4,b*8];
0.3.wait;
(
d = [
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)]
];
);
0.3.wait;
(
e = [
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)]
];
);
0.3.wait;
f = Scale.choose;
0.3.wait;
(
g = [
	f.degreeToFreq(1, 60.midicps, rrand(1,1)),
	f.degreeToFreq(2, 60.midicps, rrand(1,1)),f.degreeToFreq(3, 60.midicps, rrand(1,1)),
	f.degreeToFreq(4, 60.midicps, rrand(1,1)),f.degreeToFreq(5, 60.midicps, rrand(1,1)),
	f.degreeToFreq(6, 60.midicps, rrand(1,1)),f.degreeToFreq(7, 60.midicps, rrand(1,1))
];
);
0.3.wait;
(
h = [
	g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
	g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
	g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)]
]
);
0.3.wait;
(
Tdef(\a, { var probTime;
	probTime = [
		rrand(0.0,1.0),rrand(0.0,1.0),rrand(0.0,1.0),
		rrand(0.0,1.0),rrand(0.0,1.0),rrand(0.0,1.0),
		rrand(0.0,1.0),rrand(0.0,1.0),rrand(0.0,1.0),
		rrand(0.0,1.0),rrand(0.0,1.0),rrand(0.0,1.0)].normalizeSum;
	loop({
		12.do({ |i,time,vol,reldiv|
			time = d.wchoose(probTime);
			vol = [0,0.5,1].wchoose([0.0,0.5,0.5].normalizeSum);
			reldiv = rrand(1.0,5.0);
			~b.set(\vol, vol,\t_trig, 1, \release, time, \reldiv, reldiv);
			m.sendMsg("/A1Scale", vol*10.0);
			time.wait;
		~b.set(\vol, 0, \t_trig, 0);
			m.sendMsg("/A1Scale", 0.0);
			time.wait
		})
	})
})
);
0.3.wait;
(
Tdef(\b, { var probTime;
	probTime = [
		rrand(0.0,1.0),rrand(0.0,1.0),rrand(0.0,1.0),
		rrand(0.0,1.0),rrand(0.0,1.0),rrand(0.0,1.0),
		rrand(0.0,1.0),rrand(0.0,1.0),rrand(0.0,1.0),
		rrand(0.0,1.0),rrand(0.0,1.0),rrand(0.0,1.0)].normalizeSum;
	loop({
		12.do({ |i,time,vol,reldiv,tri|
			time = d.wchoose(probTime);
			vol = [0,0.1,0.2].wchoose([0.0,0.5,0.5].normalizeSum);
			reldiv = rrand(1.0,10.0);
			~c.set(\vol, vol,\t_trig, 1, \release, time, \reldiv, reldiv);
			m.sendMsg("/A2Scale", vol*10.0);
			time.wait;
		~c.set(\vol, 0, \t_trig, 0);
			m.sendMsg("/A2Scale", 0.0);
			time.wait
		})
	})
})
);
0.3.wait;
(
Tdef(\c, {
	loop({ var arrayRep = [rrand(6,12),rrand(12,12),rrand(6,12),rrand(12,12)];
		(
			h = [
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)]
			]
		);
		arrayRep[0].do({
			arrayRep[1].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1].normalizeSum);
			~d.set(\vol, vol,\t_trig, 1, \freq, h[i]/2);
				m.sendMsg("/A3Scale", vol*10.0);
				m.sendMsg("/A3Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		 });
		arrayRep[2].do({
			arrayRep[3].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1.0].normalizeSum);
			~d.set(\vol, vol,\t_trig, 1, \freq, h[i]/2);
				m.sendMsg("/A3Scale", vol*10);
				m.sendMsg("/A3Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		})
	})
});
);
0.3.wait;
(
Tdef(\d, { var
	array = Array.fill(100, {|i| i = i + 1});
	array = array.reverse;
	loop({ var tempi = rrand(0.01,0.4), tempi2 = rrand(3.0,12.0);
	~e.set(\freq, h[rrand(0,6)]);
	100.do({ |i|
		~e.set(\vol, (i/1000));
			m.sendMsg("/A4Scale", i/5);
        tempi.wait;
	});
	tempi2.wait;
	100.do({ |i|
		~e.set(\vol, (array[i]/1000));
			m.sendMsg("/A4Scale", (array[i]/5));
        tempi.wait;
	})
	})
})
);
0.3.wait;
~f.play;
0.3.wait;
(
~f = { arg vol, t_trig, release, reldiv, freq, delay = 1;
	Pan2.ar(
	    RLPF.ar(RHPF.ar(
		CombC.ar(
		PlayBuf.ar(1,a,freq/1000,1,0,1) + SinOsc.ar(freq,0,1)
		+ SinOsc.ar(freq/2,0,8) + SinOsc.ar(freq*10,0,10)
			,0.2,0.2,delay),
			freq,0.1,1),freq/10,0.9,100) * EnvGen.kr(Env.perc(0.1,1, vol/100),t_trig)
		,-1)
}
);
0.3.wait;
~g.play;
0.3.wait;
(
~g = { arg vol, t_trig, release, reldiv, freq, delay = 1;
	Pan2.ar(
	    RLPF.ar(RHPF.ar(
		CombC.ar(
		PlayBuf.ar(1,a,freq/1000,1,0,1) + SinOsc.ar(freq,0,1)
		+ SinOsc.ar(freq/2,0,8) + SinOsc.ar(freq*10,0,10)
			,0.2,0.2,delay),
			freq,0.1,1),freq/10,0.9,100) * EnvGen.kr(Env.perc(0.1,1, vol/100),t_trig)
		,1)
}
);
0.3.wait;
~h.play;
0.3.wait;
(
~h = { arg vol, t_trig, release, reldiv, freq, delay = 1;
	Pan2.ar(
	    RLPF.ar(RHPF.ar(
		CombC.ar(
		PlayBuf.ar(1,a,freq/1000,1,0,1) + SinOsc.ar(freq,0,1)
		+ SinOsc.ar(freq/2,0,8) + SinOsc.ar(freq*10,0,10)
			,0.2,0.2,delay),
			freq,0.1,1),freq/10,0.9,100) * EnvGen.kr(Env.perc(0.1,1, vol/150),t_trig)
		,0)
}
);
0.3.wait;
(
Tdef(\e, {
	loop({ var arrayRep = [rrand(6,12),rrand(12,12),rrand(6,12),rrand(12,12)];
		(
			h = [
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)]
			]
		);
		arrayRep[0].do({
			arrayRep[1].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1].normalizeSum);
			~f.set(\vol, vol,\t_trig, 1, \freq, h[i]);
				m.sendMsg("/A1Scale", vol*10.0);
				m.sendMsg("/A1Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		 });
		arrayRep[2].do({
			arrayRep[3].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1.0].normalizeSum);
			~f.set(\vol, vol,\t_trig, 1, \freq, h[i]);
				m.sendMsg("/A1Scale", vol*10);
				m.sendMsg("/A1Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		})
	})
});
);
0.3.wait;
(
Tdef(\f, {
	loop({ var arrayRep = [rrand(6,12),rrand(12,12),rrand(6,12),rrand(12,12)];
		(
			h = [
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)]
			]
		);
		arrayRep[0].do({
			arrayRep[1].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1].normalizeSum);
			~g.set(\vol, vol,\t_trig, 1, \freq, h[i]*2);
				m.sendMsg("/A2Scale", vol*10.0);
				m.sendMsg("/A2Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		 });
		arrayRep[2].do({
			arrayRep[3].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1.0].normalizeSum);
			~g.set(\vol, vol,\t_trig, 1, \freq, h[i]*2);
				m.sendMsg("/A2Scale", vol*10);
				m.sendMsg("/A2Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		})
	})
});
);
0.3.wait;
(
Tdef(\g, {
	loop({ var arrayRep = [rrand(6,12),rrand(12,12),rrand(6,12),rrand(12,12)];
		(
			h = [
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)]
			]
		);
		arrayRep[0].do({
			arrayRep[1].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1].normalizeSum);
			~h.set(\vol, vol,\t_trig, 1, \freq, h[i]*4);
				m.sendMsg("/A4Scale", vol*10.0);
				m.sendMsg("/A4Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		 });
		arrayRep[2].do({
			arrayRep[3].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1.0].normalizeSum);
			~h.set(\vol, vol,\t_trig, 1, \freq, h[i]*4);
				m.sendMsg("/A4Scale", vol*10);
				m.sendMsg("/A4Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		})
	})
});
);
0.3.wait;
"nxAM-Beta LOADED".postln;
Server.default.recHeaderFormat = "WAV";
0.3.wait;
Server.default.prepareForRecord(t++".wav");
0.3.wait;
v = "ffmpeg -f x11grab -r 25 -s 1440x900 -i :0.0 -vcodec libx264 -vpre lossless_ultrafast -threads 0 " ++ t ++".mkv";
0.3.wait;
10.wait;
v.unixCmd; Server.default.record;
5.wait;
Tdef(\c).play; m.sendMsg("/title", "");
	rrand(45,60).wait;
	Tdef(\e).play;
	rrand(45,60).wait;
	Tdef(\f).play;
	rrand(45,60).wait;
	Tdef(\g).play;
(
Tdef(\e, {
	loop({ var arrayRep = [rrand(6,12),rrand(12,12),rrand(6,12),rrand(12,12)];
		(
			x = [
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)]
			]
		);
		arrayRep[0].do({
			arrayRep[1].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1].normalizeSum);
			~f.set(\vol, vol,\t_trig, 1, \freq, x[i]);
				m.sendMsg("/A1Scale", vol*10.0);
				m.sendMsg("/A1Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		 });
		arrayRep[2].do({
			arrayRep[3].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1.0].normalizeSum);
			~f.set(\vol, vol,\t_trig, 1, \freq, x[i]);
				m.sendMsg("/A1Scale", vol*10);
				m.sendMsg("/A1Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		})
	})
}).play;
);
	rrand(45,60).wait;
(
Tdef(\f, {
	loop({ var arrayRep = [rrand(6,12),rrand(12,12),rrand(6,12),rrand(12,12)];
		(
			y = [
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)]
			]
		);
		arrayRep[0].do({
			arrayRep[1].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1].normalizeSum);
			~g.set(\vol, vol,\t_trig, 1, \freq, y[i]*2);
				m.sendMsg("/A2Scale", vol*10.0);
				m.sendMsg("/A2Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		 });
		arrayRep[2].do({
			arrayRep[3].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1.0].normalizeSum);
			~g.set(\vol, vol,\t_trig, 1, \freq, y[i]*2);
				m.sendMsg("/A2Scale", vol*10);
				m.sendMsg("/A2Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		})
	})
}).play;
);
	rrand(20,40).wait;

(
Tdef(\g, {
	loop({ var arrayRep = [rrand(6,12),rrand(12,12),rrand(6,12),rrand(12,12)];
		(
			z = [
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
				g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)]
			]
		);
		arrayRep[0].do({
			arrayRep[1].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1].normalizeSum);
			~h.set(\vol, vol,\t_trig, 1, \freq, z[i]*4);
				m.sendMsg("/A4Scale", vol*10.0);
				m.sendMsg("/A4Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		 });
		arrayRep[2].do({
			arrayRep[3].do({ |i,vol|
			vol = [0,0.5,1].wchoose([0.0,0.0,1.0].normalizeSum);
			~h.set(\vol, vol,\t_trig, 1, \freq, z[i]*4);
				m.sendMsg("/A4Scale", vol*10);
				m.sendMsg("/A4Angles", (h[i].asInt/100).asInt);
			e[i].wait;
		});
		})
	})
}).play;
);
	rrand(45,66).wait;
Tdef(\g).pause; m.sendMsg("/A4Scale", 0.0);
	rrand(12,24).wait;
Tdef(\f).pause; m.sendMsg("/A2Scale", 0.0);
	rrand(12,24).wait;
Tdef(\e).pause; m.sendMsg("/A1Scale", 0.0);
	rrand(12,24).wait;
Tdef(\c).pause; m.sendMsg("/A3Scale", 0.0);
1.wait;
"killall java".unixCmd; "killall ffmpeg".unixCmd; Server.default.stopRecording;
}).play;
)
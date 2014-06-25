
// nxAM Control

b = rrand(0.2,0.4);

c = [b/8,b/4,b/2,b,b*2,b*4,b*8];
(
d = [
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)],
	c[rrand(0,2)],c[rrand(0,2)],c[rrand(0,2)]
];
)

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
)

f = Scale.choose;
(
g = [
	f.degreeToFreq(1, 60.midicps, rrand(1,1)),
	f.degreeToFreq(2, 60.midicps, rrand(1,1)),f.degreeToFreq(3, 60.midicps, rrand(1,1)),
	f.degreeToFreq(4, 60.midicps, rrand(1,1)),f.degreeToFreq(5, 60.midicps, rrand(1,1)),
	f.degreeToFreq(6, 60.midicps, rrand(1,1)),f.degreeToFreq(7, 60.midicps, rrand(1,1))
];
)

(
h = [
	g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
	g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)],
	g[rrand(0,6)],g[rrand(0,6)],g[rrand(0,6)]
]
)

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
)

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
)

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
)

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
)

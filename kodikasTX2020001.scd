s.waitForBoot {

    SynthDef(\leadSynth, {
        |out=0, freq=440, dur=0.2, amp=0.5|
        var sig = Pulse.ar(freq, 0.4) * Line.kr(amp, 0, dur);
        Out.ar(out, sig);
    }).add;

    SynthDef(\padSynth, {
        |out=0, freq=330, dur=0.3, amp=0.3|
        var sig = Saw.ar(freq, 0.3) * Line.kr(amp, 0, dur);
        Out.ar(out, sig);
    }).add;

    SynthDef(\percussion, {
        |out=0, dur=0.4, amp=0.6|
        var sig = Mix.fill(2, { PinkNoise.ar * EnvGen.kr(Env.perc(0.01, 0.1), doneAction: 2) });
        Out.ar(out, sig * amp);
    }).add;

    SynthDef(\subBass, {
        |out=0, freq=55, dur=0.5, amp=0.6|
        var sig = SinOsc.ar(freq, 0, amp) + Pulse.ar(freq * 0.5, 0.2);
        Out.ar(out, sig);
    }).add;

   SynthDef(\keys, {
    |out=0, freq=72, dur=0.4, amp=0.5|
    var sig = LFTri.ar(freq, 0, amp);
    Out.ar(out, sig);
}).add;

    Pbind(
        \instrument, \leadSynth,
        \degree, Pseq([0, 3, 5, 7, 8, 7, 5, 3], inf),
        \dur, 0.4,
        \amp, 0.5
    ).play;

    Pbind(
        \instrument, \padSynth,
        \degree, Pseq([7, 5, 3, 2], inf),
        \dur, 0.5,
        \amp, 0.4
    ).play;

    Pbind(
        \instrument, \leadSynth,
        \degree, Pseq([0, 2, 4, 5], inf),
        \dur, 0.3,
        \amp, 0.6
    ).play;

    Pbind(
        \instrument, \percussion,
        \dur, Pseq([0.2, 0.2, 0.2, 0.2], inf),
        \amp, 0.7
    ).play;

    Pmono(
        \instrument, \subBass,
        \degree, Pseq([0, -3, -5, -7], inf),
        \legato, 0.4,
        \amp, 0.6
    ).play;

    Pbind(
        \instrument, \keys,
        \degree, Pseq([0, 4, 7, 10], inf),
        \dur, 0.6,
        \amp, 0.4
    ).play;

    60.wait;

    Pdef.all.do(_.stop);
};

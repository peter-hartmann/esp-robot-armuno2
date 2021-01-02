function onload() {
    var [el_robot, el_cmd, el_connections, el_debug] = document.querySelectorAll('pre');
    var [el_program] = document.querySelectorAll('textarea');
    let socket = new WebSocket(location.origin.replace(/^http/, 'ws'));
    socket.onopen = function (e) {
        socket.send('{"type":"Browser"}');
        socket.send('aa=0'); // query the robot state
    };
    socket.onmessage = function ({ data }) {
        if (data[0] === '{') {
            var jso = JSON.parse(data);
            el_connections.innerText = JSON.stringify(jso, null, 2);
            return;
        }
        el_robot.innerText = data;
    };
    var gr = -15;
    document.onkeydown = function (evt) {
        evt = evt || window.event;
        playing = false;
        // el_debug.innerText = document.activeElement;
        if (document.activeElement === el_program) {
            if (evt.key === 'ArrowUp' || evt.key === 'ArrowDown') {
                var prg = el_program.value;
                var cur = prg.substr(0, el_program.selectionStart).split("\n").length - 1;
                if (evt.key === 'ArrowUp') cur += cur > 0 ? -1 : 0;
                if (evt.key === 'ArrowDown') cur += 1;
                var cmd = prg.split(/\r?\n/)[cur];
                if (cmd) control(cmd);
            }
        }
        if (document.activeElement === document.body) {
            var key = evt.key.toUpperCase();
            if (key == 'A') { control("lr+1"); }
            if (key == 'D') { control("lr+-1"); }
            if (key == 'W') { control("fb+1"); }
            if (key == 'S') { control("fb+-1"); }
            if (key == 'E') { control("ud+1"); }
            if (key == 'Q') { control("ud+-1"); }
            if (key == ' ') { control("gr+" + (gr = -gr)); }
            if (key == 'R') { record(); }
            if (key == 'P') { play(); }
            if (key == 'O') { play(true); }
        }
    };
    function control(s) {
        el_cmd.innerText = s;
        socket.send(s);
    }
    function record() {
        el_program.value += el_robot.innerText + '\n';
    }
    var playing = false;
    async function play(reverse) {
        if (playing) return;
        playing = true;
        var lines = el_program.value.split(/\r?\n/).filter(line => line.trim());
        if (reverse) lines.reverse();
        while (playing && lines.length) {
            var line = lines.shift();
            control(line);
            for (; el_robot.innerText.trim() !== line.trim();) {
                await new Promise(re => setTimeout(re, 200));
            }
        }
        playing = false;
    }
    el_program.value = localStorage.getItem('program1') || '';
    setInterval(() => {
        localStorage.setItem('program1', el_program.value);
    }, 2000);
}
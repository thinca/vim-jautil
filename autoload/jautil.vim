scriptversion 4
scriptencoding utf-8

let s:hiragana = split('あ い う え お か き く け こ さ し す せ そ た ち つ て と な に ぬ ね の は ひ ふ へ ほ ま み む め も や ゆ よ ら り る れ ろ わ を ん ゔ が ぎ ぐ げ ご ざ じ ず ぜ ぞ だ ぢ づ で ど ば び ぶ べ ぼ ぱ ぴ ぷ ぺ ぽ ぁ ぃ ぅ ぇ ぉ ゃ ゅ ょ っ ゐ ゑ', ' ')
let s:katakana = split('ア イ ウ エ オ カ キ ク ケ コ サ シ ス セ ソ タ チ ツ テ ト ナ ニ ヌ ネ ノ ハ ヒ フ ヘ ホ マ ミ ム メ モ ヤ ユ ヨ ラ リ ル レ ロ ワ ヲ ン ヴ ガ ギ グ ゲ ゴ ザ ジ ズ ゼ ゾ ダ ヂ ヅ デ ド バ ビ ブ ベ ボ パ ピ プ ペ ポ ァ ィ ゥ ェ ォ ャ ュ ョ ッ ヰ ヱ', ' ')

let s:zenkaku= {
\   'number': split('０ １ ２ ３ ４ ５ ６ ７ ８ ９', ' '),
\   'alpha': split('Ａ Ｂ Ｃ Ｄ Ｅ Ｆ Ｇ Ｈ Ｉ Ｊ Ｋ Ｌ Ｍ Ｎ Ｏ Ｐ Ｑ Ｒ Ｓ Ｔ Ｕ Ｖ Ｗ Ｘ Ｙ Ｚ ａ ｂ ｃ ｄ ｅ ｆ ｇ ｈ ｉ ｊ ｋ ｌ ｍ ｎ ｏ ｐ ｑ ｒ ｓ ｔ ｕ ｖ ｗ ｘ ｙ ｚ', ' '),
\   'kana': split('ヴ ガ ギ グ ゲ ゴ ザ ジ ズ ゼ ゾ ダ ヂ ヅ デ ド バ ビ ブ ベ ボ パ ピ プ ペ ポ ア イ ウ エ オ カ キ ク ケ コ サ シ ス セ ソ タ チ ツ テ ト ナ ニ ヌ ネ ノ ハ ヒ フ ヘ ホ マ ミ ム メ モ ヤ ユ ヨ ラ リ ル レ ロ ワ ヲ ン ァ ィ ゥ ェ ォ ャ ュ ョ ッ ー ◌゙ ◌゚ 、 。 ・ 「 」', ' '),
\   'symbol': split('！ ＂ ＃ ＄ ％ ＆ ＇ （ ） ＊ ＋ ， － ． ／ ： ； ＜ ＝ ＞ ？ ＠ ［ ＼ ］ ＾ ＿ ｀ ～ ｛ ｜ ｝', ' '),
\   'space': ['　'],
\ }

let s:hankaku = {
\   'number': split('0123456789', '\zs'),
\   'alpha': split('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', '\zs'),
\   'kana': split('ｳﾞ ｶﾞ ｷﾞ ｸﾞ ｹﾞ ｺﾞ ｻﾞ ｼﾞ ｽﾞ ｾﾞ ｿﾞ ﾀﾞ ﾁﾞ ﾂﾞ ﾃﾞ ﾄﾞ ﾊﾞ ﾋﾞ ﾌﾞ ﾍﾞ ﾎﾞ ﾊﾟ ﾋﾟ ﾌﾟ ﾍﾟ ﾎﾟ ｱ ｲ ｳ ｴ ｵ ｶ ｷ ｸ ｹ ｺ ｻ ｼ ｽ ｾ ｿ ﾀ ﾁ ﾂ ﾃ ﾄ ﾅ ﾆ ﾇ ﾈ ﾉ ﾊ ﾋ ﾌ ﾍ ﾎ ﾏ ﾐ ﾑ ﾒ ﾓ ﾔ ﾕ ﾖ ﾗ ﾘ ﾙ ﾚ ﾛ ﾜ ｦ ﾝ ｧ ｨ ｩ ｪ ｫ ｬ ｭ ｮ ｯ ｰ ﾞ ﾟ ､ ｡ ･ ｢ ｣ ', ' '),
\   'symbol': split('!"#$%&''()*+,-./:;<=>?@[\]^_`~{|}', '\zs'),
\   'space': [' '],
\ }

function s:register_table(table, list_a, list_b) abort
  for i in range(len(a:list_a))
    let a:table[a:list_a[i]] = a:list_b[i]
    let a:table[a:list_b[i]] = a:list_a[i]
  endfor
endfunction

let s:hirakata_table = {}
call s:register_table(s:hirakata_table, s:hiragana, s:katakana)
let s:zenhan_table = {}
for s:type in keys(s:zenkaku)
  call s:register_table(s:zenhan_table, s:zenkaku[s:type], s:hankaku[s:type])
endfor
unlet s:type

let s:target_tables = {
\   'hiragana': s:hirakata_table,
\   'katakana': s:hirakata_table,
\   'hirakata': s:hirakata_table,
\   'zenkaku': s:zenhan_table,
\   'hankaku': s:zenhan_table,
\   'zenhan': s:zenhan_table,
\ }

let s:type_regexps = {
\   'hiragana': join(s:hiragana, '\|'),
\   'katakana': join(s:katakana, '\|'),
\   'hirakata': join(s:hiragana + s:katakana, '\|'),
\   'zenkaku:number': join(s:zenkaku.number, '\|'),
\   'zenkaku:alpha': join(s:zenkaku.alpha, '\|'),
\   'zenkaku:kana': join(s:zenkaku.kana, '\|'),
\   'zenkaku:symbol': join(s:zenkaku.symbol, '\|'),
\   'zenkaku:space': join(s:zenkaku.space, '\|'),
\   'hankaku:number': join(s:hankaku.number, '\|'),
\   'hankaku:alpha': join(s:hankaku.alpha, '\|'),
\   'hankaku:kana': join(s:hankaku.kana, '\|'),
\   'hankaku:symbol': join(s:hankaku.symbol, '\|'),
\   'hankaku:space': join(s:hankaku.space, '\|'),
\   'zenhan:number': join(s:zenkaku.number + s:hankaku.number, '\|'),
\   'zenhan:alpha': join(s:zenkaku.alpha + s:hankaku.alpha, '\|'),
\   'zenhan:kana': join(s:zenkaku.kana + s:hankaku.kana, '\|'),
\   'zenhan:symbol': join(s:zenkaku.symbol + s:hankaku.symbol, '\|'),
\   'zenhan:space': join(s:zenkaku.space + s:hankaku.space, '\|'),
\ }

let s:default_types = {
\   'hiragana': [],
\   'katakana': [],
\   'hirakata': [],
\   'zenkaku': ['all'],
\   'hankaku': ['all'],
\   'zenhan': ['all'],
\ }

let s:type_aliases = {
\   'alnum': ['alpha', 'number'],
\   'ascii': ['alpha', 'number', 'symbol', 'space'],
\   'all': ['alpha', 'number', 'symbol', 'space', 'kana'],
\ }


function jautil#convert(str, targets) abort
  let str = a:str
  let targets = a:targets

  if type(str) is# v:t_list && type(targets) is# v:t_string
    let [str, targets] = [targets, str]
  endif

  for target in type(targets) is# v:t_list ? targets : [targets]
    let str = s:convert(str, target)
  endfor
  return str
endfunction

function s:convert(str, target) abort
  let [target_name; rest] = split(a:target, ':')

  if !has_key(s:target_tables, target_name)
    throw 'jautil: Invalid target: ' .. target_name
  endif
  let table = s:target_tables[target_name]

  let types = empty(rest) ? s:default_types[target_name] : split(rest[0], '+')
  let regexp = '\V' .. s:get_type_regexp(target_name, types)

  let s:table = table
  return substitute(a:str, regexp, function('s:convert_by_table'), 'g')
endfunction

function s:get_type_regexp(target_name, types) abort
  let types = s:expand_types(a:types)
  let target_key = a:target_name
  if !empty(types)
    let target_key ..= ':' .. join(types, '+')
  endif
  if has_key(s:type_regexps, target_key)
    return s:type_regexps[target_key]
  endif
  let regexps = []
  for type in types
    let key = a:target_name .. ':' .. type
    if !has_key(s:type_regexps, key)
      throw 'jautil: Invalid type: ' .. type
    endif
    let regexps += [s:type_regexps[key]]
  endfor
  let regexp = join(regexps, '\|')
  let s:type_regexps[target_key] = regexp
  return regexp
endfunction

function s:expand_types(types) abort
  let types = []
  for type in a:types
    if has_key(s:type_aliases, type)
      let types += s:type_aliases[type]
    else
      let types += [type]
    endif
  endfor
  return uniq(sort(types))
endfunction

function s:convert_by_table(matched) abort
  return s:table[a:matched[0]]
endfunction

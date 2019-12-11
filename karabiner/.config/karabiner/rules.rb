TMUX_TERMINALS = %i[^com.googlecode.iterm2 ^net.kovidgoyal.kitty ^io.alacritty]
TERMINALS = TMUX_TERMINALS + %i[^com.apple.Terminal ^com.github.atom]

rule(
  "Change double caps_lock to caps_lock",
  from: from(:caps_lock, optional: %i[caps_lock]),
  to: to(key_code: :caps_lock),
  conditions: variable_is(:caps_lock_double, 1)
)


rule(
  "Change caps_lock to f20 (hyper key) and set hyper_modifier or esc if pressed alone",
  parameters: {
    "basic.to_if_alone_timeout_milliseconds" => 200,
    "basic.to_delayed_action_delay_milliseconds" => 250
  },
  from: from(:caps_lock, optional: %i[any]),
  to: to(
    set_variable(:hyper_modifier, 1),
    set_variable(:caps_lock_double, 1),
    key_code: :f20
  ),
  to_after_key_up: to(set_variable(:hyper_modifier, 0)),
  to_if_alone: to(key_code: :escape),
  to_delayed_action: {
    to_if_invoked: to(set_variable(:caps_lock_double, 0)),
    to_if_canceled: to(set_variable(:caps_lock_double, 0))
  }
)

rule(
  "Change hyper + h/j/k/l to arrow keys",
  *{
    h: :left_arrow,
    j: :down_arrow,
    k: :up_arrow,
    l: :right_arrow
  }.map do |letter, mapping|
    {
      conditions: variable_is(:hyper_modifier, 1),
      from: from(letter),
      to: to(key_code: mapping)
    }
  end
)

{
  v: "Change hyper + v to old hyper v for Launchbar clipboard paste menu",
  backslash: "Change hyper + # to old hyper # for 1Password browser extension",
  hyphen: "Change hyper + ß to old hyper ß for Dash"
}.each do |letter, description|
  rule(
    description,
    conditions: variable_is(:hyper_modifier, 1),
    from: from(letter),
    to: to(key_code: letter, modifiers: %i[right_control right_option right_shift right_command])
  )
end

rule(
  "Change right_command to right_control in terminals",
  conditions: app_is(TERMINALS),
  from: from(:right_command),
  to: to(key_code: :right_control)
)

rule(
  "Swallow command + w in terminals to prevent accidental window closing",
  conditions: app_is(TERMINALS),
  from: from(:w, mandatory: :command)
)

rule(
  "Change tab to tmux_modifier or tab if pressed alone in tmux terminals",
  conditions: [app_is(TMUX_TERMINALS), variable_unless(:hyper_modifier, 1)],
  parameters: { "basic.to_if_alone_timeout_milliseconds" => 200 },
  from: from(:tab, optional: %i[any]),
  to: to(set_variable(:tmux_modifier, 1)),
  to_after_key_up: to(set_variable(:tmux_modifier, 0)),
  to_if_alone: to(key_code: :tab)
)

rule(
  "Change tmux + appropriate letters to ctrl-b <letter>",
  ctrl_b(:b, to_letter: nil),
  *%i[1 2 3 4 5 6 7 8 9].map { |letter| ctrl_b(letter) },
  ctrl_b(:period, modifier: :shift),
  *%i[comma r y i z c p n left_arrow right_arrow].map { |letter| ctrl_b(letter) },
  ctrl_b(:s),
  ctrl_b(:s, modifier: :left_control, optional_any: true),
  ctrl_b(:v),
  ctrl_b(:v, modifier: :left_control, optional_any: true),
  *%i[h j k l d].map { |letter| ctrl_b(letter) },
)

def parenthesis(key_code, modifier: nil, to_key_code:, to_modifier:, terminals_only: nil)
  from_params = {}
  from_params[:mandatory] = modifier if modifier
  to_params = { key_code: key_code }
  to_params[:modifiers] = modifier if modifier
  rule = {
    parameters: { "basic.to_if_alone_timeout_milliseconds" => 200 },
    from: from(key_code, **from_params),
    to: to(**to_params),
    to_if_alone: to(key_code: to_key_code.to_s, modifiers: [to_modifier])
  }
  rule[:conditions] = app_is(TERMINALS) if terminals_only == true
  rule[:conditions] = app_is_not(TERMINALS) if terminals_only == false
  rule
end

rule(
  "Change left/right_shift to opening/closing parenthesis",
  parenthesis(:left_shift, to_key_code: 8, to_modifier: :shift),
  parenthesis(:right_shift, to_key_code: 9, to_modifier: :shift),
)

rule(
  "Change left_command + left/right_shift to opening/closing square brackets",
  parenthesis(:left_shift, modifier: :left_command, to_key_code: 5, to_modifier: :option),
  parenthesis(:right_shift, modifier: :left_command, to_key_code: 6, to_modifier: :option),
)

rule(
  "Change right_command + left/right_shift to opening/closing curly brackets in non-terminals",
  parenthesis(:left_shift, modifier: :right_command, to_key_code: 8, to_modifier: :option, terminals_only: false),
  parenthesis(:right_shift, modifier: :right_command, to_key_code: 9, to_modifier: :option, terminals_only: false),
)

rule(
  "Change right_control + left/right_shift to opening/closing curly brackets in terminals",
  parenthesis(:left_shift, modifier: :right_control, to_key_code: 8, to_modifier: :option, terminals_only: true),
  parenthesis(:right_shift, modifier: :right_control, to_key_code: 9, to_modifier: :option, terminals_only: true),
)

rule(
  "Change alt space (nonbreaking space) to space",
  from: from(:spacebar, mandatory: %i[option]),
  to: to(key_code: :spacebar)
)

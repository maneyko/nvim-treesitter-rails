;; extends

; Vim Ruby syntax groups. This is meant as a complete replacement of the nvim-treesitter Ruby highlight groups.

; Treesitter syntax reference:        https://tree-sitter.github.io/tree-sitter/using-parsers/queries/index.html
; Neovim treesitter highlight groups: https://neovim.io/doc/user/treesitter/#treesitter-highlight
; nvim-treesitter highlights file:    https://github.com/nvim-treesitter/nvim-treesitter/blob/main/runtime/queries/ruby/highlights.scm


; Declarations and definitions.
[
  "alias"
  "def"
  "undef"
] @keyword.function

"class"  @keyword.type.class
"module" @keyword.type.module

; Ensure `end` has same highlight group as `class`, `def`, `module`, etc.
(class  "end" @keyword.type.class)
(module "end" @keyword.type.module)
(method "end" @keyword.function)
(singleton_method "end" @keyword.function)

; Make `rescue` and `ensure` have same highlight color as `def..end`
(method           body: (body_statement (rescue "rescue" @keyword.function (#set! priority 105))))
(method           body: (body_statement (ensure "ensure" @keyword.function (#set! priority 105))))
(singleton_method body: (body_statement (rescue "rescue" @keyword.function (#set! priority 105))))
(singleton_method body: (body_statement (ensure "ensure" @keyword.function (#set! priority 105))))

; Class and module names
(class  name: (constant) @type.class_name)
(module name: (constant) @type.module_name)

(method           name: (identifier) @function)
(singleton_method name: (identifier) @function)
(alias  (identifier) @function)
(setter (identifier) @function)

; Keywords and flow control.
[
  "break"
  "next"
  "redo"
  "retry"
] @keyword.control

[
  "case"
  "else"
  "elsif"
  "if"
  "unless"
  "when"
  "then"
] @keyword.conditional

(if "end" @keyword.conditional) ; Ensure `end` has same highlight color as `if`
(in_clause "in" @keyword.conditional) ; Pattern matching (for `case` statement)

[
  "for"
  "until"
  "while"
] @keyword.repeat
(call . method: (identifier) @keyword.repeat (#eq? @keyword.repeat "loop"))

[
  "and"
  "or"
  "in"
  "not"
] @keyword.operator

[
  "rescue"
  "ensure"
] @keyword.exception

; Top-level `BEGIN` and `END` blocks (like awk)
[
  (begin_block)
  (end_block)
] @keyword.routine.global

[
  (super)
  (yield)
  "return"
] @keyword.return

; Pseudo variables and built-ins.
[
  (self)
] @variable.builtin

[
  (true)
  (false)
] @boolean

(constant) @constant

((constant) @constant.global.predefined
  (#any-of? @constant.global.predefined
     "STDIN" "STDOUT" "STDERR" "ENV" "ARGF" "ARGV" "TOPLEVEL_BINDING" "DATA"
     "RUBY_VERSION" "RUBY_RELEASE_DATE" "RUBY_PLATFORM" "RUBY_PATCHLEVEL" "RUBY_REVISION"
     "RUBY_COPYRIGHT" "RUBY_ENGINE" "RUBY_ENGINE_VERSION" "RUBY_DESCRIPTION"
     "CROSS_COMPILING"
  )
)

(class_variable)    @variable.member.class
(instance_variable) @variable.member.instance
(global_variable)   @variable.member.global

((global_variable) @variable.member.global.predefined
  (#any-of? @variable.member.global.predefined
    "$!" "$@" "$~" "$&" "$`" "$'" "$+" "$/" "$;" "$\\" "$stdin" "$stdout" "$stderr"
    "$<" "$>" "$." "$_" "$0" "$*" "$$" "$?" "$LOAD_PATH" "$LOADED_FEATURES" "$FILENAME"
    "$DEBUG" "$VERBOSE" "$-a" "$-i" "$-l" "$-p"
  )
)

((global_variable) @variable.member.global.predefined
  (#lua-match? @variable.member.global.predefined "^$[1-9][0-9]*$")
)

(integer) @number.integer
(float)   @number.float
(nil) @constant.builtin.null

[
  (bare_symbol)
  (simple_symbol)
  (hash_key_symbol)
  (delimited_symbol)
] @string.special.symbol
((bare_string) @string)

(delimited_symbol (string_content) @string.special.symbol (#set! priority 110))
(bare_symbol      (string_content) @string.special.symbol (#set! priority 110))

(string_array
  "%w(" @string.array
  ")" @string.array
)

(symbol_array
  "%i(" @string.special.symbol.array
  ")" @string.special.symbol.array
)

[
  "?"
  ":"
] @operator.ternary

[
  "**"
  "*"
  "/"
  "%"
  "+"
  "-"
] @operator.arithmetic

[
  "<=>"
  "<="
  "<"
  ">="
  ">"
] @operator.comparison

[
  "~"
  "^"
  "|"
  "&"
  "<<"
  ">>"
] @operator.bitwise

[
  "!"
  "&&"
  "||"
] @operator.boolean

(range [".." "..."] @operator.range)
((forward_argument) @operator.forward_argument)

[
  "="
  "=>"
  "-="
  "/="
  "**="
  "*="
  "&&="
  "&="
  "||="
  "|="
  "%="
  "+="
  ">>="
  "<<="
  "^="
] @operator.assignment

[
  "==="
  "=="
  "!="
  "!~"
  "=~"
] @operator.equality

[
  "."
  "&."
  "::"
  "->"
] @operator.pseudo

; Strings, regexps, interpolation, and escapes.
[
  (string_content)
  (heredoc_content)
] @string

(escape_sequence) @string.escape

(interpolation
  "#{" @punctuation.special
  "}" @punctuation.special)

[
  (heredoc_beginning)
  (heredoc_end)
] @label

(regex) @regexp
(regex
  "/" @punctuation.delimiter.regexp
  "/" @punctuation.delimiter.regexp)
(regex (string_content) @string.regexp)
; TODO: Handle special regex characters

; End of hard node processing. Start of pseudo node processing:

((identifier) @constant.builtin.keyword
  (#any-of? @constant.builtin.keyword "__ENCODING__" "__FILE__" "__LINE__")
)

; Kernel "builtin" methods: https://docs.ruby-lang.org/en/3.4/Kernel.html
(call .
  method: (identifier) @function.builtin.querying.magic
  (#any-of? @function.builtin.querying.magic "__callee__" "__dir__" "__method__")
)

(call .
  method: (identifier) @function.builtin.querying
  (#any-of? @function.builtin.querying "caller" "caller_locations")
)

(call .
  method: (identifier) @function.builtin.exiting
  (#any-of? @function.builtin.exiting "abort" "at_exit" "exit" "exit!")
)

(call .
  method: (identifier) @function.builtin.exceptions
  (#any-of? @function.builtin.exceptions "catch" "fail" "raise" "throw")
)

((identifier) @function.builtin.io
  (#any-of? @function.builtin.io
   "binding" "gets" "open" "print" "printf" "putc" "puts" "readline" "readlines" "sleep" "sprintf"
   "test" "warn"
   ; "p" "pp" "j" "jj" "y" "select"
  )
)

(call .
  method: (identifier) @function.builtin.procs
  (#any-of? @function.builtin.procs "lambda" "proc")
)

(call .
  method: (identifier) @function.builtin.subprocesses
  (#any-of? @function.builtin.subprocesses "exec" "fork" "spawn" "system" "syscall" "trap")
)

(call .
  method: (identifier) @keyword.import
  (#any-of? @keyword.import "autoload" "gem" "load" "require" "require_relative")
)


(call .
  method: (identifier) @function.builtin.eval
  (#any-of? @function.builtin.eval "eval" "class_eval" "instance_eval" "module_eval")
)

; Module methods: https://docs.ruby-lang.org/en/3.4/Module.html#method-i-private
(call .
  method: (identifier) @keyword.modifier
  (#any-of? @keyword.modifier "public" "protected" "private")
)

(call .
  method: (identifier) @function.builtin.module.attribute
  (#any-of? @function.builtin.module.attribute "attr" "attr_accessor" "attr_reader" "attr_writer")
)

(call .
  method: (identifier) @function.builtin.module.exec
  (#any-of? @function.builtin.module.exec
   "alias_method" "class_exec" "module_exec" "define_method" "define_singleton_method"
   "deprecate_constant" "remove_method" "undef_method"
  )
)

(call .
  method: (identifier) @function.builtin.module.const
  (#any-of? @function.builtin.module.const "const_defined?" "const_get" "const_set" "remove_const")
)

(call .
  method: (identifier) @keyword.import.include
  (#any-of? @keyword.import.include "extend" "include" "prepend" "refine" "using")
)

(call .
  method: (identifier) @keyword.modifier
  (#any-of? @keyword.modifier
    "public" "protected" "private" "public_class_method" "private_class_method"
    "public_constant" "private_constant" "module_function"
  )
)

(uninterpreted) @data

; Create target for keyword arguments
(keyword_parameter name: (identifier) @variable.parameter.keyword)

; Implicit block parameter: it
((identifier) @variable.parameter.builtin.block.implicit
  (#eq? @variable.parameter.builtin.block.implicit "it")
  (#has-ancestor? @variable.parameter.builtin.block.implicit block do_block)
)

; Numbered block parameters: _1, _2
((identifier) @variable.parameter.builtin.block.numbered
  (#lua-match? @variable.parameter.builtin.block.numbered "^_[1-9]$")
  (#has-ancestor? @variable.parameter.builtin.block.numbered block do_block)
)

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^=begin")
)

((comment) @comment.magic
  (#lua-match? @comment.magic "^#%s*[Cc][Oo][Dd][Ii][Nn][Gg]:")
  (#ruby-magic-comment! @comment.magic "key")
)
((comment) @comment.magic
  (#lua-match? @comment.magic "^#%s*[Ee][Nn][Cc][Oo][Dd][Ii][Nn][Gg]:")
  (#ruby-magic-comment! @comment.magic "key")
)
((comment) @comment.magic
  (#lua-match? @comment.magic "^#%s*[Ff][Rr][Oo][Zz][Ee][Nn][-_][Ss][Tt][Rr][Ii][Nn][Gg][-_][Ll][Ii][Tt][Ee][Rr][Aa][Ll]:")
  (#ruby-magic-comment! @comment.magic "key")
)
((comment) @comment.magic
  (#lua-match? @comment.magic "^#%s*[Ww][Aa][Rr][Nn][-_][Ii][Nn][Dd][Ee][Nn][Tt]:")
  (#ruby-magic-comment! @comment.magic "key")
)
((comment) @comment.magic
  (#lua-match? @comment.magic "^#%s*[Ww][Aa][Rr][Nn][-_][Pp][Aa][Ss][Tt][-_][Ss][Cc][Oo][Pp][Ee]:")
  (#ruby-magic-comment! @comment.magic "key")
)
((comment) @comment.magic
  (#lua-match? @comment.magic "^#%s*[Ss][Hh][Aa][Rr][Ee][Aa][Bb][Ll][Ee][-_][Cc][Oo][Nn][Ss][Tt][Aa][Nn][Tt][-_][Vv][Aa][Ll][Uu][Ee]:")
  (#ruby-magic-comment! @comment.magic "key")
)

((comment) @boolean
  (#lua-match? @boolean "^#%s*[Ff][Rr][Oo][Zz][Ee][Nn][-_][Ss][Tt][Rr][Ii][Nn][Gg][-_][Ll][Ii][Tt][Ee][Rr][Aa][Ll]:%s*[Tt][Rr][Uu][Ee]")
  (#ruby-magic-comment! @boolean "boolean")
)
((comment) @boolean
  (#lua-match? @boolean "^#%s*[Ff][Rr][Oo][Zz][Ee][Nn][-_][Ss][Tt][Rr][Ii][Nn][Gg][-_][Ll][Ii][Tt][Ee][Rr][Aa][Ll]:%s*[Ff][Aa][Ll][Ss][Ee]")
  (#ruby-magic-comment! @boolean "boolean")
)
((comment) @boolean
  (#lua-match? @boolean "^#%s*[Ww][Aa][Rr][Nn][-_][Ii][Nn][Dd][Ee][Nn][Tt]:%s*[Tt][Rr][Uu][Ee]")
  (#ruby-magic-comment! @boolean "boolean")
)
((comment) @boolean
  (#lua-match? @boolean "^#%s*[Ww][Aa][Rr][Nn][-_][Ii][Nn][Dd][Ee][Nn][Tt]:%s*[Ff][Aa][Ll][Ss][Ee]")
  (#ruby-magic-comment! @boolean "boolean")
)
((comment) @boolean
  (#lua-match? @boolean "^#%s*[Ww][Aa][Rr][Nn][-_][Pp][Aa][Ss][Tt][-_][Ss][Cc][Oo][Pp][Ee]:%s*[Tt][Rr][Uu][Ee]")
  (#ruby-magic-comment! @boolean "boolean")
)
((comment) @boolean
  (#lua-match? @boolean "^#%s*[Ww][Aa][Rr][Nn][-_][Pp][Aa][Ss][Tt][-_][Ss][Cc][Oo][Pp][Ee]:%s*[Ff][Aa][Ll][Ss][Ee]")
  (#ruby-magic-comment! @boolean "boolean")
)
((comment) @encoding
  (#lua-match? @encoding "^#%s*[Cc][Oo][Dd][Ii][Nn][Gg]:%s*%S+")
  (#ruby-magic-comment! @encoding "encoding")
)
((comment) @encoding
  (#lua-match? @encoding "^#%s*[Ee][Nn][Cc][Oo][Dd][Ii][Nn][Gg]:%s*%S+")
  (#ruby-magic-comment! @encoding "encoding")
)
((comment) @encoding
  (#lua-match? @encoding "^#%s*[Ss][Hh][Aa][Rr][Ee][Aa][Bb][Ll][Ee][-_][Cc][Oo][Nn][Ss][Tt][Aa][Nn][Tt][-_][Vv][Aa][Ll][Uu][Ee]:%s*%S+")
  (#ruby-magic-comment! @encoding "encoding")
)

((comment) @comment.todo (#lua-match? @comment.todo "FIXME")    )
((comment) @comment.todo (#lua-match? @comment.todo "NOTE")     )
((comment) @comment.todo (#lua-match? @comment.todo "TODO")     )
((comment) @comment.todo (#lua-match? @comment.todo "OPTIMIZE") )
((comment) @comment.todo (#lua-match? @comment.todo "HACK")     )
((comment) @comment.todo (#lua-match? @comment.todo "REVIEW")   )
((comment) @comment.todo (#lua-match? @comment.todo "XXX")      )

; Rails-wide app macros from rails.vim's application-aware section.
(call .
  method: (identifier) @rails.attribute
  (#any-of? @rails.attribute
    "class_attribute"
    "attr_internal" "attr_internal_accessor" "attr_internal_reader" "attr_internal_writer"
    "cattr_accessor" "cattr_reader" "cattr_writer" "mattr_accessor" "mattr_reader" "mattr_writer"
    "thread_cattr_accessor" "thread_cattr_reader" "thread_cattr_writer"
    "thread_mattr_accessor" "thread_mattr_reader" "thread_mattr_writer"))

(call .
  method: (identifier) @rails.macro
  (#any-of? @rails.macro "alias_attribute" "concern" "concerning" "delegate" "delegate_missing_to" "with_options"))

; app/{channels,controllers,helpers,jobs,mailers,models}/*.rb and app/views/*.
((#is-rails-app-ruby?)
  (call .
    method: (identifier) @rails.helper
    (#eq? @rails.helper "logger")
))

; app/models/*_observer.rb.
((#is-rails-model-observer?)
  (call .
    method: (identifier) @rails.macro
    (#eq? @rails.macro "observe")
))

; app/models/*.rb.
((#is-active-record?)
  (call .
    method: (identifier) @rails.macro
    (#any-of? @rails.macro
      "accepts_nested_attributes_for" "attr_readonly" "attribute" "encrypts" "enum" "normalizes" "serialize"
      "store" "store_accessor" "default_scope" "scope" "validate" "has_rich_text" "has_secure_password"
      "has_secure_token" "has_one_attached" "has_many_attached" "delegated_type"
    )
))
((#is-active-record?)
  (call .
    method: (identifier) @rails.entity
    (#any-of? @rails.entity "belongs_to" "has_one" "composed_of" "has_many" "has_and_belongs_to_many")
))
((#is-active-record?)
  (call .
    method: (identifier) @rails.callback
    (#any-of? @rails.callback
      "before_validation" "after_validation"
      "before_create" "before_destroy" "before_save" "before_update"
      "after_create" "after_destroy" "after_save" "after_update"
      "around_create" "around_destroy" "around_save" "around_update"
      "after_commit" "after_create_commit" "after_update_commit" "after_save_commit" "after_destroy_commit" "after_rollback"
      "after_find" "after_initialize" "after_touch"
    )
))
((#is-active-record?)
  (call .
    method: (identifier) @rails.validation
    (#any-of? @rails.validation
      "validates" "validates_acceptance_of" "validates_associated" "validates_confirmation_of" "validates_each"
      "validates_exclusion_of" "validates_format_of" "validates_inclusion_of" "validates_length_of" "validates_numericality_of"
      "validates_presence_of" "validates_absence_of" "validates_size_of" "validates_with" "validates_uniqueness_of"
    )
))

; app/jobs/*.rb.
((#is-rails-job?)
  (call .
    method: (identifier) @rails.macro
    (#eq? @rails.macro "queue_as")
))
((#is-rails-job?)
  (call .
    method: (identifier) @rails.macro
    (#any-of? @rails.macro "rescue_from" "retry_on" "discard_on")
))
((#is-rails-job?)
  (call .
    method: (identifier) @rails.callback
    (#any-of? @rails.callback "before_enqueue" "around_enqueue" "after_enqueue" "before_perform" "around_perform" "after_perform")
))

; app/helpers/*_helper.rb and app/views/*.
((#is-rails-helper-or-view?)
  (call .
  method: (identifier) @rails.view_helper
    (#any-of? @rails.view_helper
      "action_name" "asset_path" "asset_url" "atom_feed" "audio_path" "audio_tag" "audio_url" "auto_discovery_link_tag"
      "button_tag" "button_to" "cache" "cache_fragment_name" "cache_if" "cache_unless" "caching?" "capture"
      "cdata_section" "check_box" "check_box_tag" "class_names" "collection_check_boxes" "collection_radio_buttons"
      "collection_select" "color_field" "color_field_tag" "compute_asset_extname" "compute_asset_host" "compute_asset_path"
      "concat" "content_for" "content_for?" "content_tag" "controller" "controller_name" "controller_path"
      "convert_to_model" "cookies" "csp_meta_tag" "csrf_meta_tag" "csrf_meta_tags" "current_cycle" "current_page?"
      "cycle" "date_field" "date_field_tag" "date_select" "datetime_field" "datetime_field_tag" "datetime_local_field"
      "datetime_local_field_tag" "datetime_select" "debug" "distance_of_time_in_words" "distance_of_time_in_words_to_now"
      "dom_class" "dom_id" "email_field" "email_field_tag" "escape_javascript" "escape_once" "excerpt" "favicon_link_tag"
      "field_id" "field_name" "field_set_tag" "fields" "fields_for" "file_field" "file_field_tag" "flash"
      "font_path" "font_url" "form_for" "form_tag" "form_with" "grouped_collection_select" "grouped_options_for_select"
      "headers" "hidden_field" "hidden_field_tag" "highlight" "image_path" "image_submit_tag" "image_tag"
      "image_url" "j" "javascript_cdata_section" "javascript_include_tag" "javascript_path" "javascript_tag"
      "javascript_url" "l" "label" "label_tag" "link_to" "link_to_if" "link_to_unless" "link_to_unless_current"
      "localize" "mail_to" "month_field" "month_field_tag" "number_field" "number_field_tag" "number_to_currency"
      "number_to_human" "number_to_human_size" "number_to_percentage" "number_to_phone" "number_with_delimiter"
      "number_with_precision" "option_groups_from_collection_for_select" "options_for_select" "options_from_collection_for_select"
      "params" "password_field" "password_field_tag" "path_to_asset" "path_to_audio" "path_to_font" "path_to_image"
      "path_to_javascript" "path_to_stylesheet" "path_to_video" "phone_field" "phone_field_tag" "phone_to"
      "pluralize" "preload_link_tag" "provide" "public_compute_asset_path" "radio_button" "radio_button_tag"
      "range_field" "range_field_tag" "raw" "render" "request" "request_forgery_protection_token" "reset_cycle"
      "response" "safe_concat" "safe_join" "sanitize" "sanitize_css" "search_field" "search_field_tag" "select"
      "select_date" "select_datetime" "select_day" "select_hour" "select_minute" "select_month" "select_second"
      "select_tag" "select_time" "select_year" "session" "simple_format" "sms_to" "strip_links" "strip_tags"
      "stylesheet_link_tag" "stylesheet_path" "stylesheet_url" "submit_tag" "t" "tag" "telephone_field"
      "telephone_field_tag" "text_area" "text_area_tag" "text_field" "text_field_tag" "time_ago_in_words"
      "time_field" "time_field_tag" "time_select" "time_tag" "time_zone_options_for_select" "time_zone_select"
      "to_sentence" "token_list" "translate" "truncate" "uncacheable!" "url_field" "url_field_tag" "url_for"
      "url_to_asset" "url_to_audio" "url_to_font" "url_to_image" "url_to_javascript" "url_to_stylesheet"
      "url_to_video" "utf8_enforcer_tag" "video_path" "video_tag" "video_url" "week_field" "week_field_tag"
      "weekday_options_for_select" "weekday_select" "word_wrap" "h" "html_escape" "u" "url_encode" "asset_pack_path"
      "image_pack_tag" "javascript_pack_tag" "stylesheet_pack_tag" "action_cable_meta_tag" "local_assigns"
    )
))

; app/controllers/*.rb.
((#is-rails-controller?)
  (call .
    method: (identifier) @rails.helper
    (#any-of? @rails.helper "params" "request" "response" "session" "headers" "cookies" "flash")
))
((#is-rails-controller?)
  (call .
    method: (identifier) @rails.macro
    (#any-of? @rails.macro "protect_from_forgery" "skip_forgery_protection" "http_basic_authenticate_with" "respond_to")
))
((#is-rails-controller?)
  (call .
    method: (identifier) @rails.response
    (#any-of? @rails.response
      "render" "head" "redirect_to" "redirect_back" "redirect_back_or_to" "respond_with" "send_data" "send_file"
      "authenticate_or_request_with_http_basic" "authenticate_with_http_basic" "http_basic_authenticate_or_request_with"
      "request_http_basic_authentication"
    )
))

; app/controllers/*.rb, app/mailers/*.rb, app/models/*_mailer.rb.
((#is-rails-controller-or-mailer?)
  (call .
    method: (identifier) @rails.helper
    (#eq? @rails.helper "render_to_string")
))
((#is-rails-controller-or-mailer?)
  (call .
    method: (identifier) @rails.callback
    (#any-of? @rails.callback
      "before_action" "append_before_action" "prepend_before_action" "after_action" "append_after_action"
      "prepend_after_action" "around_action" "append_around_action" "prepend_around_action" "skip_before_action"
      "skip_after_action" "skip_around_action" "skip_action"
    )
))
((#is-rails-controller-or-mailer?)
  (call .
    method: (identifier) @rails.macro
    (#any-of? @rails.macro "helper" "helper_attr" "helper_method" "layout" "rescue_from")
))

; app/mailers/*.rb and app/models/*_mailer.rb.
((#is-rails-mailer?)
  (call .
    method: (identifier) @rails.response
    (#any-of? @rails.response "mail" "render" "headers")
))
((#is-rails-mailer?)
  (call .
    method: (identifier) @rails.helper
    (#any-of? @rails.helper "headers" "params" "attachments")
))
((#is-rails-mailer?)
  (call .
    method: (identifier) @rails.macro
    (#any-of? @rails.macro "default" "register_interceptor" "register_interceptors" "register_observer" "register_observers")
))

; app/*/concerns/*.rb.
((#is-rails-concern?)
  (call .
    method: (identifier) @rails.macro
    (#any-of? @rails.macro "included" "class_methods")
))

; URL helpers in controllers/helpers/mailers/views/request specs/system tests.
((#is-rails-url-helper-context?)
  (call .
    method: (identifier) @rails.url_helper
    (#any-of? @rails.url_helper
      "url_for" "polymorphic_path" "polymorphic_url" "edit_polymorphic_path" "edit_polymorphic_url"
      "new_polymorphic_path" "new_polymorphic_url"
    )
))

; db/migrate/*.rb and db/schema.rb.
((#is-rails-schema?)
  (call .
    method: (identifier) @rails.schema
    (#any-of? @rails.schema
      "create_table" "change_table" "drop_table" "rename_table" "create_join_table" "drop_join_table" "create_schema"
      "drop_schema" "add_column" "rename_column" "change_column" "change_column_default" "change_column_null"
      "remove_column" "remove_columns" "add_foreign_key" "remove_foreign_key" "add_timestamps" "remove_timestamps"
      "add_reference" "remove_reference" "add_belongs_to" "remove_belongs_to" "add_index" "remove_index"
      "rename_index" "enable_extension" "reversible" "revert" "execute" "transaction"
    )
))

; *.rake and Rakefile*.
((#is-ruby-rake?)
  (call .
    method: (identifier) @rails.rake
    (#any-of? @rails.rake "task" "file" "namespace" "desc")
))

; config/routes*.rb.
((#is-rails-routes?)
  (call .
    method: (identifier) @rails.route
    (#any-of? @rails.route
      "resource" "resources" "collection" "member" "new" "nested" "shallow"
      "match" "get" "put" "patch" "post" "delete" "root" "mount"
      "scope" "controller" "namespace" "constraints" "defaults"
      "concern" "concerns" "direct" "resolve"
    )
))
((#is-rails-routes?)
  (call .
    method: (identifier) @rails.helper
    (#eq? @rails.helper "redirect")
))

; Minitest/Cucumber tests.
((#is-rails-test?)
  (call .
    method: (identifier) @rails.assertion
    (#any-of? @rails.assertion
      "assert_block" "assert_empty" "assert_equal" "assert_in_delta" "assert_in_epsilon" "assert_includes"
      "assert_instance_of" "assert_kind_of" "assert_match" "assert_mock" "assert_nil" "assert_no_match"
      "assert_not_empty" "assert_not_equal" "assert_not_in_delta" "assert_not_in_epsilon" "assert_not_includes"
      "assert_not_instance_of" "assert_not_kind_of" "assert_not_nil" "assert_not_operator" "assert_not_predicate"
      "assert_not_respond_to" "assert_not_same" "assert_not_send" "assert_not" "assert_nothing_raised"
      "assert_nothing_thrown" "assert_operator" "assert_output" "assert_predicate" "assert_raise_with_message"
      "assert_raise" "assert_raises" "assert_respond_to" "assert_same" "assert_send" "assert_silent" "assert_throws"
      "assert" "flunk" "refute_empty" "refute_equal" "refute_in_delta" "refute_in_epsilon" "refute_includes"
      "refute_instance_of" "refute_kind_of" "refute_match" "refute_nil" "refute_operator" "refute_predicate"
      "refute_respond_to" "refute_same" "refute"
    )
))

; RSpec specs.
((#is-rspec?)
  (call .
    method: (identifier) @rails.test.helper
    (#eq? @rails.test.helper "subject")
))
((#is-rspec?)
  (call .
    method: (identifier) @rails.test.macro
    (#any-of? @rails.test.macro
      "let" "let!" "given" "subject" "before" "after" "around" "background" "setup" "teardown"
      "context" "describe" "feature" "shared_context" "shared_examples" "shared_examples_for"
      "it" "example" "specify" "scenario" "include_examples" "include_context" "it_should_behave_like"
      "it_behaves_like"
    )
))
((#is-rspec?)
  (call .
    method: (identifier) @rails.debug
    (#any-of? @rails.debug "fcontext" "fdescribe" "fit" "fexample" "fspecify")
))
((#is-rspec?)
  (call .
    method: (identifier) @rails.pending
    (#any-of? @rails.pending "xcontext" "xdescribe" "xfeature" "xit" "xexample" "xspecify" "xscenario")
))
((#is-rspec-or-cucumber?)
  (call .
    method: (identifier) @rails.assertion
    (#any-of? @rails.assertion
      "pending" "skip" "expect" "is_expected" "expect_any_instance_of" "allow" "allow_any_instance_of"
    )
))
((#is-rspec-or-cucumber?)
  (call .
    [
      method: (identifier)
      receiver: (identifier)
    ] @rails.test.helper
    (#any-of? @rails.test.helper
      "described_class" "double" "instance_double" "class_double" "object_double" "spy" "instance_spy"
      "class_spy" "object_spy"
    )
))
((#is-rspec-or-cucumber?)
  (call .
    method: (identifier) @rails.test.action
    (#any-of? @rails.test.action "stub_const" "hide_const")
))

; Rails test helpers/macros/assertions.
((#is-rails-unit-test?)
  (call .
    method: (identifier) @rails.test.macro
    (#any-of? @rails.test.macro "test" "setup" "teardown")
))
((#is-rails-spec-or-test?)
  (call .
    method: (identifier) @rails.test.macro
    (#any-of? @rails.test.macro "fixtures" "use_transactional_tests" "use_instantiated_fixtures")
))
((#is-rails-spec-or-test?)
  (call .
    method: (identifier) @rails.test.helper
    (#eq? @rails.test.helper "file_fixture")
))
((#is-rails-unit-test?)
  (call .
    method: (identifier) @rails.assertion
    (#any-of? @rails.assertion
      "assert_difference" "assert_no_difference" "assert_changes" "assert_no_changes"
      "assert_emails" "assert_enqueued_emails" "assert_no_emails" "assert_no_enqueued_emails"
    )
))
((#is-rails-unit-test?)
  (call .
    method: (identifier) @rails.test.action
    (#any-of? @rails.test.action "travel" "travel_to" "travel_back" "freeze_time" "unfreeze_time")
))
((#is-rails-controller-integration-system-test?)
  (call .
    method: (identifier) @rails.assertion
    (#any-of? @rails.assertion
      "assert_response" "assert_redirected_to" "assert_template" "assert_recognizes" "assert_generates" "assert_routing"
    )
))
((#is-rails-controller-helper-integration-system-test?)
  (call .
    method: (identifier) @rails.assertion
    (#any-of? @rails.assertion
      "assert_dom_equal" "assert_dom_not_equal" "assert_select" "assert_select_encoded" "assert_select_email"
    )
))
((#is-rails-controller-helper-integration-system-test?)
  (call .
    method: (identifier) @rails.test.helper
    (#eq? @rails.test.helper "css_select")
))

; Rails system tests.
((#is-rails-system-test?)
  (call .
    method: (identifier) @rails.assertion
    (#any-of? @rails.assertion
      "assert_matches_css" "assert_matches_selector" "assert_matches_xpath" "refute_matches_css" "refute_matches_selector"
      "refute_matches_xpath" "assert_not_matches_css" "assert_not_matches_selector" "assert_not_matches_xpath"
      "assert_button" "assert_checked_field" "assert_content" "assert_css" "assert_current_path" "assert_field"
      "assert_link" "assert_select" "assert_selector" "assert_table" "assert_text" "assert_title" "assert_unchecked_field"
      "assert_xpath" "assert_no_button" "assert_no_checked_field" "assert_no_content" "assert_no_css" "assert_no_current_path"
      "assert_no_field" "assert_no_link" "assert_no_select" "assert_no_selector" "assert_no_table" "assert_no_text"
      "assert_no_title" "assert_no_unchecked_field" "assert_no_xpath" "refute_button" "refute_checked_field"
      "refute_content" "refute_css" "refute_current_path" "refute_field" "refute_link" "refute_select" "refute_selector"
      "refute_table" "refute_text" "refute_title" "refute_unchecked_field" "refute_xpath"
    )
))

; RSpec Rails subdirectories.
((#is-rspec-controller?)
  (call .
    method: (identifier) @rails.test.macro
    (#eq? @rails.test.macro "render_views")
))
((#is-rspec-controller?)
  (call .
    method: (identifier) @rails.test.helper
    (#eq? @rails.test.helper "assigns")
))
((#is-rspec-helper?)
  (call .
    method: (identifier) @rails.test.action
    (#eq? @rails.test.action "assign")
))
((#is-rspec-helper?)
  (call .
    method: (identifier) @rails.test.helper
    (#eq? @rails.test.helper "helper")
))
((#is-rspec-view?)
  (call .
    method: (identifier) @rails.test.action
    (#any-of? @rails.test.action "assign" "render")
))
((#is-rspec-view?)
  (call .
    method: (identifier) @rails.test.helper
    (#eq? @rails.test.helper "rendered")
))

; Controller/request/integration specs/tests.
((#is-rails-request-test-context?)
  (call .
    method: (identifier) @rails.test.action
    (#any-of? @rails.test.action
     "get" "post" "put" "patch" "delete" "head" "process" "follow_redirect!" "get_via_redirect" "post_via_redirect"
    )
))
((#is-rails-request-test-context?)
  (call .
    method: (identifier) @rails.test.helper
    (#any-of? @rails.test.helper "request" "response" "flash" "session" "cookies" "fixture_file_upload")
))

((#is-rails-system-test-or-feature-spec?)
  (call .
    method: (identifier) @rails.test.action
    (#any-of? @rails.test.action
      "evaluate_script" "execute_script" "go_back" "go_forward" "open_new_window" "save_and_open_page" "save_and_open_screenshot"
      "save_page" "save_screenshot" "switch_to_frame" "switch_to_window" "visit" "window_opened_by" "within"
      "within_element" "within_fieldset" "within_frame" "within_table" "within_window" "reset_session!"
      "attach_file" "check" "choose" "click_button" "click_link" "click_link_or_button" "click_on" "fill_in"
      "select" "uncheck" "unselect")
))

((#is-rails-system-test-or-feature-spec?)
  (call .
    [
      receiver: (identifier) ; Target as a chained call: page.visit("foo")
      method: (identifier)   ; Target as a regular method call: page().text
    ] @rails.test.helper
  )
  (#any-of? @rails.test.helper
    "body" "current_host" "current_path" "current_scope" "current_url" "current_window" "html" "response_headers"
    "source" "status_code" "title" "windows" "page" "text" "all" "field_labeled" "find" "find_all" "find_button"
    "find_by_id" "find_field" "find_link" "first"
))
; Target as a regular identifier: expect(page).to have_text("foo")
((#is-rails-system-test-or-feature-spec?)
  (identifier) @rails.test.helper
  (#any-of? @rails.test.helper
    "body" "current_host" "current_path" "current_scope" "current_url" "current_window" "html" "response_headers"
    "source" "status_code" "title" "windows" "page" "text" "all" "field_labeled" "find" "find_all" "find_button"
    "find_by_id" "find_field" "find_link" "first"
  )
  (#not-has-parent? @rails.test.helper call)
)

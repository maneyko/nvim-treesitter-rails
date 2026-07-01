;; extends

; ------------------------------------------------------------------------
; Vim Ruby syntax groups, translated from syntax/ruby.vim.
; ------------------------------------------------------------------------

; https://tree-sitter.github.io/tree-sitter/using-parsers/queries/index.html


; Declarations and definitions.
[
  "alias"
  "def"
  "undef"
] @vim_ruby.define (#set! priority 110)

"class" @vim_ruby.class (#set! priority 110)
"module" @vim_ruby.module (#set! priority 110)

(method
  name: (identifier) @vim_ruby.method_name (#set! priority 120))
(singleton_method
  name: (identifier) @vim_ruby.method_name (#set! priority 120))
(alias
  (identifier) @vim_ruby.method_name (#set! priority 120))
(setter
  (identifier) @vim_ruby.method_name (#set! priority 120))

; Keywords and flow control.
[
  "break"
  "next"
  "redo"
  "retry"
  "return"
] @vim_ruby.control (#set! priority 110)

[
  "case"
  "else"
  "elsif"
  "if"
  "unless"
  "when"
  "then"
] @vim_ruby.conditional (#set! priority 110)

[
  "for"
  "until"
  "while"
] @vim_ruby.repeat (#set! priority 110)

[
  "rescue"
  "ensure"
] @vim_ruby.exception_handler (#set! priority 110)

; Top-level `BEGIN` and `END` blocks (like awk)
[
  (begin_block)
  (end_block)
] @vim_ruby.begin_end (#set! priority 110)

[
  (super)
  (yield)
] @vim_ruby.keyword (#set! priority 110)

; Pseudo variables and built-ins.
[
  (self)
  (nil)
] @vim_ruby.pseudo_variable (#set! priority 110)

[
  (true)
  (false)
] @vim_ruby.boolean (#set! priority 110)

((identifier) @vim_ruby.pseudo_variable
  (#any-of? @vim_ruby.pseudo_variable "__ENCODING__" "__dir__" "__FILE__" "__LINE__" "__callee__" "__method__")
  (#set! priority 110))

; Special methods.
(call .
  method: (identifier) @vim_ruby.access
  (#any-of? @vim_ruby.access
    "public" "protected" "private" "public_class_method" "private_class_method"
    "public_constant" "private_constant" "module_function")
  (#set! priority 110))

(call .
  method: (identifier) @vim_ruby.attribute
  (#any-of? @vim_ruby.attribute "attr" "attr_accessor" "attr_reader" "attr_writer")
  (#set! priority 110))

(call .
  method: (identifier) @vim_ruby.control
  (#any-of? @vim_ruby.control "abort" "at_exit" "exit" "exit!" "fork" "loop" "trap")
  (#set! priority 110))

(call .
  method: (identifier) @vim_ruby.eval
  (#any-of? @vim_ruby.eval "eval" "class_eval" "instance_eval" "module_eval")
  (#set! priority 110))

(call .
  method: (identifier) @vim_ruby.exception
  (#any-of? @vim_ruby.exception "raise" "fail" "catch" "throw")
  (#set! priority 110))

(call .
  method: (identifier) @vim_ruby.include
  (#any-of? @vim_ruby.include "autoload" "gem" "load" "require" "require_relative")
  (#set! priority 110))

(call .
  method: (identifier) @vim_ruby.keyword
  (#any-of? @vim_ruby.keyword "callcc" "caller" "lambda" "proc")
  (#set! priority 110))

((identifier) @vim_ruby.macro
  (#any-of? @vim_ruby.macro
    "extend" "include" "prepend" "refine" "using"
    "alias_method" "define_method" "define_singleton_method" "remove_method" "undef_method")
  (#set! priority 110))
(call .
  method: (identifier) @vim_ruby.macro
  (#any-of? @vim_ruby.macro
    "extend" "include" "prepend" "refine" "using"
    "alias_method" "define_method" "define_singleton_method" "remove_method" "undef_method")
  (#set! priority 110))

; Constants, variables, symbols, and numbers.
(class
  name: (constant) @vim_ruby.class_name (#set! priority 105))
(module
  name: (constant) @vim_ruby.module_name (#set! priority 105))
(constant) @vim_ruby.constant

((constant) @vim_ruby.predefined_constant
  (#any-of? @vim_ruby.predefined_constant
    "ARGF" "ARGV" "ENV" "DATA" "STDERR" "STDIN" "STDOUT" "TOPLEVEL_BINDING"
    "RUBY_VERSION" "RUBY_RELEASE_DATE" "RUBY_PLATFORM" "RUBY_PATCHLEVEL" "RUBY_REVISION"
    "RUBY_DESCRIPTION" "RUBY_COPYRIGHT" "RUBY_ENGINE" "FALSE" "NIL" "TRUE")
  (#set! priority 110))

(class_variable)    @vim_ruby.class_variable
(instance_variable) @vim_ruby.instance_variable
(global_variable)   @vim_ruby.global_variable

((global_variable) @vim_ruby.predefined_variable
  (#any-of? @vim_ruby.predefined_variable
    "$!" "$@" "$$" "$&" "$`" "$'" "$+" "$0" "$/" "$\\" "$," "$;" "$~" "$=" "$:"
    "$<" "$>" "$." "$?" "$_" "$-0" "$-F" "$-I" "$-K" "$-W" "$-a" "$-d" "$-i" "$-l"
    "$-p" "$-v" "$-w" "$stderr" "$stdin" "$stdout" "$DEBUG" "$FILENAME" "$LOADED_FEATURES"
    "$LOAD_PATH" "$PROGRAM_NAME" "$SAFE" "$VERBOSE" "$deferr" "$defout" "$KCODE")
  (#set! priority 110))

(integer) @vim_ruby.integer
(float)   @vim_ruby.float

[
  (bare_symbol)
  (simple_symbol)
  (hash_key_symbol)
  (delimited_symbol)
] @vim_ruby.symbol

; Operators, split according to the optional ruby.vim operator groups.
[
  "and"
  "or"
  "not"
] @vim_ruby.operator.english_boolean (#set! priority 110)

[
  "?"
  ":"
] @vim_ruby.operator.ternary (#set! priority 110)

[
  "**"
  "*"
  "/"
  "%"
  "+"
  "-"
] @vim_ruby.operator.arithmetic (#set! priority 110)

[
  "<=>"
  "<="
  "<"
  ">="
  ">"
] @vim_ruby.operator.comparison (#set! priority 110)

[
  "~"
  "^"
  "|"
  "&"
  "<<"
  ">>"
] @vim_ruby.operator.bitwise (#set! priority 110)

[
  "!"
  "&&"
  "||"
] @vim_ruby.operator.boolean (#set! priority 110)

[
  ".."
  "..."
] @vim_ruby.operator.range (#set! priority 110)

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
] @vim_ruby.operator.assignment (#set! priority 110)

[
  "==="
  "=="
  "!="
  "!~"
  "=~"
] @vim_ruby.operator.equality (#set! priority 110)

[
  "."
  "&."
  "::"
  "->"
] @vim_ruby.operator.pseudo (#set! priority 110)

; Strings, regexps, interpolation, and escapes.
[
  (string_content)
  (heredoc_content)
] @vim_ruby.string

(escape_sequence) @vim_ruby.string_escape

(interpolation
  "#{" @vim_ruby.interpolation_delimiter
  "}" @vim_ruby.interpolation_delimiter)

[
  (heredoc_beginning)
  (heredoc_end)
] @vim_ruby.heredoc_delimiter

(regex) @vim_ruby.regexp
(regex
  "/" @vim_ruby.regexp_delimiter
  "/" @vim_ruby.regexp_delimiter)
(regex
  (string_content) @vim_ruby.regexp_content)
; TODO: Handle special regex characters

; Comments and documentation.
((comment) @vim_ruby.sharpbang
  (#lua-match? @vim_ruby.sharpbang "^#!")
  (#set! priority 120))

((comment) @vim_ruby.magic_comment
  (#lua-match? @vim_ruby.magic_comment "^#%s*[Cc][Oo][Dd][Ii][Nn][Gg]:")
  (#ruby-magic-comment! @vim_ruby.magic_comment "key")
  (#set! priority 120))
((comment) @vim_ruby.magic_comment
  (#lua-match? @vim_ruby.magic_comment "^#%s*[Ee][Nn][Cc][Oo][Dd][Ii][Nn][Gg]:")
  (#ruby-magic-comment! @vim_ruby.magic_comment "key")
  (#set! priority 120))
((comment) @vim_ruby.magic_comment
  (#lua-match? @vim_ruby.magic_comment "^#%s*[Ff][Rr][Oo][Zz][Ee][Nn][-_][Ss][Tt][Rr][Ii][Nn][Gg][-_][Ll][Ii][Tt][Ee][Rr][Aa][Ll]:")
  (#ruby-magic-comment! @vim_ruby.magic_comment "key")
  (#set! priority 120))
((comment) @vim_ruby.magic_comment
  (#lua-match? @vim_ruby.magic_comment "^#%s*[Ww][Aa][Rr][Nn][-_][Ii][Nn][Dd][Ee][Nn][Tt]:")
  (#ruby-magic-comment! @vim_ruby.magic_comment "key")
  (#set! priority 120))
((comment) @vim_ruby.magic_comment
  (#lua-match? @vim_ruby.magic_comment "^#%s*[Ww][Aa][Rr][Nn][-_][Pp][Aa][Ss][Tt][-_][Ss][Cc][Oo][Pp][Ee]:")
  (#ruby-magic-comment! @vim_ruby.magic_comment "key")
  (#set! priority 120))
((comment) @vim_ruby.magic_comment
  (#lua-match? @vim_ruby.magic_comment "^#%s*[Ss][Hh][Aa][Rr][Ee][Aa][Bb][Ll][Ee][-_][Cc][Oo][Nn][Ss][Tt][Aa][Nn][Tt][-_][Vv][Aa][Ll][Uu][Ee]:")
  (#ruby-magic-comment! @vim_ruby.magic_comment "key")
  (#set! priority 120))

((comment) @vim_ruby.boolean
  (#lua-match? @vim_ruby.boolean "^#%s*[Ff][Rr][Oo][Zz][Ee][Nn][-_][Ss][Tt][Rr][Ii][Nn][Gg][-_][Ll][Ii][Tt][Ee][Rr][Aa][Ll]:%s*[Tt][Rr][Uu][Ee]")
  (#ruby-magic-comment! @vim_ruby.boolean "boolean")
  (#set! priority 121))
((comment) @vim_ruby.boolean
  (#lua-match? @vim_ruby.boolean "^#%s*[Ff][Rr][Oo][Zz][Ee][Nn][-_][Ss][Tt][Rr][Ii][Nn][Gg][-_][Ll][Ii][Tt][Ee][Rr][Aa][Ll]:%s*[Ff][Aa][Ll][Ss][Ee]")
  (#ruby-magic-comment! @vim_ruby.boolean "boolean")
  (#set! priority 121))
((comment) @vim_ruby.boolean
  (#lua-match? @vim_ruby.boolean "^#%s*[Ww][Aa][Rr][Nn][-_][Ii][Nn][Dd][Ee][Nn][Tt]:%s*[Tt][Rr][Uu][Ee]")
  (#ruby-magic-comment! @vim_ruby.boolean "boolean")
  (#set! priority 121))
((comment) @vim_ruby.boolean
  (#lua-match? @vim_ruby.boolean "^#%s*[Ww][Aa][Rr][Nn][-_][Ii][Nn][Dd][Ee][Nn][Tt]:%s*[Ff][Aa][Ll][Ss][Ee]")
  (#ruby-magic-comment! @vim_ruby.boolean "boolean")
  (#set! priority 121))
((comment) @vim_ruby.boolean
  (#lua-match? @vim_ruby.boolean "^#%s*[Ww][Aa][Rr][Nn][-_][Pp][Aa][Ss][Tt][-_][Ss][Cc][Oo][Pp][Ee]:%s*[Tt][Rr][Uu][Ee]")
  (#ruby-magic-comment! @vim_ruby.boolean "boolean")
  (#set! priority 121))
((comment) @vim_ruby.boolean
  (#lua-match? @vim_ruby.boolean "^#%s*[Ww][Aa][Rr][Nn][-_][Pp][Aa][Ss][Tt][-_][Ss][Cc][Oo][Pp][Ee]:%s*[Ff][Aa][Ll][Ss][Ee]")
  (#ruby-magic-comment! @vim_ruby.boolean "boolean")
  (#set! priority 121))
((comment) @vim_ruby.encoding
  (#lua-match? @vim_ruby.encoding "^#%s*[Cc][Oo][Dd][Ii][Nn][Gg]:%s*%S+")
  (#ruby-magic-comment! @vim_ruby.encoding "encoding")
  (#set! priority 121))
((comment) @vim_ruby.encoding
  (#lua-match? @vim_ruby.encoding "^#%s*[Ee][Nn][Cc][Oo][Dd][Ii][Nn][Gg]:%s*%S+")
  (#ruby-magic-comment! @vim_ruby.encoding "encoding")
  (#set! priority 121))
((comment) @vim_ruby.encoding
  (#lua-match? @vim_ruby.encoding "^#%s*[Ss][Hh][Aa][Rr][Ee][Aa][Bb][Ll][Ee][-_][Cc][Oo][Nn][Ss][Tt][Aa][Nn][Tt][-_][Vv][Aa][Ll][Uu][Ee]:%s*%S+")
  (#ruby-magic-comment! @vim_ruby.encoding "encoding")
  (#set! priority 121))

((comment) @vim_ruby.todo
  (#lua-match? @vim_ruby.todo "FIXME")
  (#set! priority 120))
((comment) @vim_ruby.todo
  (#lua-match? @vim_ruby.todo "NOTE")
  (#set! priority 120))
((comment) @vim_ruby.todo
  (#lua-match? @vim_ruby.todo "TODO")
  (#set! priority 120))
((comment) @vim_ruby.todo
  (#lua-match? @vim_ruby.todo "OPTIMIZE")
  (#set! priority 120))
((comment) @vim_ruby.todo
  (#lua-match? @vim_ruby.todo "HACK")
  (#set! priority 120))
((comment) @vim_ruby.todo
  (#lua-match? @vim_ruby.todo "REVIEW")
  (#set! priority 120))
((comment) @vim_ruby.todo
  (#lua-match? @vim_ruby.todo "XXX")
  (#set! priority 120))

((comment) @vim_ruby.comment.documentation
  (#lua-match? @vim_ruby.comment.documentation "^=begin")
  (#set! priority 120))

(uninterpreted) @vim_ruby.data

; Implicit block parameter: it
((identifier) @vim_ruby.parameter.block.implicit
  (#eq? @vim_ruby.parameter.block.implicit "it")
  (#has-ancestor? @vim_ruby.parameter.block.implicit block do_block)
)

; Numbered block parameters: _1, _2
((identifier) @vim_ruby.parameter.block.numbered
  (#lua-match? @vim_ruby.parameter.block.numbered "^_[1-9]$")
  (#has-ancestor? @vim_ruby.parameter.block.numbered block do_block)
)

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
    method: (identifier) @rails.test.helper
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

all:
	rebar get-deps && rebar compile

clean:
	rebar clean

build_plt: all
	rebar skip_deps=true build-plt

analyze: all
	dialyzer -pa deps/*/ebin --plt ~/.itweet_dialyzer_plt -Wunmatched_returns -Werror_handling -Wbehaviours ebin

doc: all
	rebar skip_deps=true doc

xref: all
	rebar skip_deps=true xref

test: all
#	echo "Running eunit tests..."
#	if [ -f test.config ]; then \
#		erl -noshell -config test -pa ebin -pa deps/*/ebin +Bc +K true -smp enable -s crypto -s ibrowse -s ssl -s itweet -run itweep_tests main; \
#	else \
#		erl -noshell              -pa ebin -pa deps/*/ebin +Bc +K true -smp enable -s crypto -s ibrowse -s ssl -s itweet -run itweep_tests main; \
#	fi
	echo "Running common tests..."
	mkdir -p log/ct
	rebar skip_deps=true ct
	open log/ct/index.html

shell: all
	erl -pa ebin -pa deps/*/ebin +Bc +K true -smp enable -boot start_sasl -s crypto -s ibrowse -s ssl -s itweet

FROM rpelavin/trusty-puppet3.7
MAINTAINER Rich Pelavin "rich@reactor8.com"

RUN apt-get install -y supervisor
COPY supervisor.conf /etc/supervisor.conf

# TODO: next step is to remove invocations and to have this be configurable through converge option
RUN mkdir -p /usr/share/dtk/dtk-apply
COPY dtk-apply /usr/share/dtk/dtk-apply

#RUN mkdir -p /etc/puppet/modules
#COPY etc/puppet/modules /etc/puppet/modules
#RUN /usr/share/dtk/dtk-apply/bin/converge.rb --logging off

CMD supervisord -c /etc/supervisor.conf


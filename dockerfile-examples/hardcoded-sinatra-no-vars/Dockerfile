FROM rpelavin/trusty-puppet3.7
MAINTAINER Rich Pelavin "rich@reactor8.com"
RUN mkdir -p /etc/puppet/modules
COPY etc/puppet/modules /etc/puppet/modules

RUN mkdir -p /usr/share/dtk/dtk-apply
COPY dtk-apply /usr/share/dtk/dtk-apply

#RUN /usr/share/dtk/dtk-apply/bin/converge.rb --logging off
RUN /usr/share/dtk/dtk-apply/bin/converge.rb 

EXPOSE 4567
WORKDIR /usr/share/sinatra/app/hello-world

CMD ["ruby","app.rb"]



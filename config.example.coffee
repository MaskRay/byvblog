module.exports =
  cookie_secret: 'secret'
  mongo:
    host: 'localhost'
    port: 27017
    db: 'byvblog'
  languages: ['zhs', 'zht', 'en']
  site:
    url: 'http://www.byvoid.com/'
    author: 'BYVoid'
    title: 'Beyond the Void'
    description: '積羽沉舟 羣輕折軸'
  options:
    postsPerPage: 6
    feedPosts: 5
    popularPosts: 30
    recentPosts: 5
  social:
    facebook: 'http://www.facebook.com/byvoid'
    twitter: "http://twitter.com/byvoid"
    gplus: "http://plus.google.com/112163558251413006250"
    linkedin: "http://www.linkedin.com/in/byvoid"
    github: "http://github.com/BYVoid"
    renren: "http://www.renren.com/byvoid"
    weibo: "http://weibo.com/byvoid"
    douban: "http://www.douban.com/people/byvoid/"
  links: [{
    name: 'AIFreedom'
    link: 'http://aifreedom.com/'
  }, {
    name: "Lan.d'sCape"
    link: 'http://www.mengyalan.com/'
  }, {
    name: 'MaskRay'
    link: 'http://maskray.me/'
  }, {
    name: '不安靜的書桌'
    link: 'http://www.liuhanyu.com/'
  }, {
    name: '獨異誌'
    link: 'http://solog.me/'
  }]
  navigator: [{
    name: 'Blog'
    link: '/'
  }, {
    name: 'Projects'
    link: '/projects'
    submenu: [{
      name: 'Accounts9'
      link: '/projects/accounts9'
    }, {
      name: 'COGS'
      link: '/projects/COGS'
    }]
  }, {
    name: 'About'
    link: '/about'
  }, {
    name: 'Contact'
    link: '/contact'
  }]
  disqus:
    shortname: 'disqus'
    developer: 0

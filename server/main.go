package main

import (
	"github.com/figoxu/gh"
	"github.com/gin-gonic/gin"
	"net/http"
	"github.com/figoxu/Figo"
	"flag"
	"fmt"
)

var (
	domain string
	port   string
)

type Env struct {
	fh *gh.FormHelper
	ph *gh.ParamHelper
}

func init() {
	flag.StringVar(&domain, "domain", "default", "domain for debug")
	flag.StringVar(&port, "port", ":3456", "port for http listen")
}

func main() {
	flag.Parse()
	fmt.Println(domain,"  ",port)
	r := gin.Default()
	r.GET("/:domain/hello", m_gh, h_domain_hello)
	r.Run(port)
}

//http://localhost:3456/figo/hello
func h_domain_hello(c *gin.Context) {
	env := c.MustGet("env").(*Env)
	param := c.Request.URL.Query()
	ph := env.ph
	domain := ph.String("domain")
	c.String(http.StatusOK, "Hello %s %s %s", domain, " query data : ", Figo.JsonString(param))
}

func m_gh(c *gin.Context) {
	c.Set("env", &Env{
		fh: gh.NewFormHelper(c),
		ph: gh.NewParamHelper(c),
	})
	c.Next()
}

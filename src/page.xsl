<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:page="http://benad.me/schema/page"
    xmlns:html="http://www.w3.org/TR/xhtml1/strict"
    exclude-result-prefixes="html page"
    version="1.0">
                    
    <xsl:output encoding="utf-8" indent="yes" method="html" omit-xml-declaration="yes"/>
    
    <xsl:template match="page:page">
        <html lang="en">
            <xsl:text>&#10;   </xsl:text>
            <head>
                <xsl:text>&#10;      </xsl:text>
                <meta charset="utf-8"/>
                <xsl:text>&#10;      </xsl:text>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <xsl:text>&#10;      </xsl:text>
                <title><xsl:if test="page:head/page:title"><xsl:value-of select="page:head/page:title"/> - </xsl:if>Benad's Web Site</title>
                <xsl:text>&#10;      </xsl:text>
                <meta name="description" content=""/>
                <xsl:text>&#10;      </xsl:text>
                <link rel="stylesheet" href="/css/oat.min.css"/>
                <xsl:text>&#10;      </xsl:text>
                <link rel="stylesheet" href="/css/main.css"/><script src="/js/oat.min.js" defer="defer"></script><link rel="me" href="https://micro.blog/benad"/>
                <xsl:text>&#10;      </xsl:text>
                <xsl:apply-templates select="page:head/page:meta/html:*"/>
                <xsl:text>&#10;   </xsl:text>
            </head>
            <xsl:text>&#10;   </xsl:text>
            <body>
                <xsl:text>&#10;      </xsl:text>
                <main style="max-width: 960px; margin: 0 auto; padding: var(--space-4);">
                    <xsl:text>&#10;         </xsl:text>
                    <header>
                        <xsl:text>&#10;            </xsl:text>
                        <xsl:choose>
                            <xsl:when test="page:head/page:title">
                                <h1>Benad's Web Site</h1>
                                <xsl:text>&#10;            </xsl:text>
                                <h2><xsl:value-of select="page:head/page:title"/></h2>
                            </xsl:when>
                            <xsl:otherwise>
                                <h1>Benad's Web Site</h1>
                            </xsl:otherwise>
                        </xsl:choose>
                        <xsl:text>&#10;         </xsl:text>
                    </header>
                    <xsl:text>&#10;         </xsl:text>
                    <div class="site-layout">
                        <xsl:text>&#10;            </xsl:text>
                        <nav>
                            <xsl:text>&#10;               </xsl:text>
                            <p><a href="/index.html">Home</a></p>
                            <xsl:text>&#10;               </xsl:text>
                            <p><a href="/blog">Blog</a></p>
                            <xsl:text>&#10;               </xsl:text>
                            <p><a href="/me.html">About Me</a></p>
                            <xsl:text>&#10;               </xsl:text>
                            <p><a href="/meta.html">About This Site</a></p>
                            <xsl:text>&#10;               </xsl:text>
                            <p><a href="/articles.html">Articles</a></p>
                            <xsl:text>&#10;               </xsl:text>
                            <p><a href="/links.html">Links</a></p>
                            <xsl:text>&#10;            </xsl:text>
                        </nav>
                        <xsl:text>&#10;            </xsl:text>
                        <section>
                            <xsl:apply-templates select="page:body/page:section"/>
                        </section>
                        <xsl:text>&#10;         </xsl:text>
                    </div>
                    <xsl:text>&#10;         </xsl:text>
                    <footer>
                        <xsl:text>&#10;            </xsl:text>
                        <hr/>
                        <xsl:text>&#10;            </xsl:text>
                        <p>Benad's Web Site by Benoit Nadeau is licensed under a <a rel="license" href="https://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a></p>
                        <xsl:text>&#10;            </xsl:text>
                        <p>Mastodon: <a rel="me" href="https://mstdn.ca/@benad">@benad@mstdn.ca</a></p>
                        <xsl:text>&#10;         </xsl:text>
                    </footer>
                    <xsl:text>&#10;      </xsl:text>
                </main>
                <xsl:text>&#10;   </xsl:text>
            </body>
            <xsl:text>&#10;</xsl:text>
        </html>
    </xsl:template>
    
    <xsl:template match="page:section">
        <xsl:if test="@title">
        <h3><xsl:value-of select="@title"/></h3>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="page:subsection">
        <xsl:if test="@title">
        <h4>
        <xsl:choose>
        <xsl:when test="@href">
        <xsl:element name="a">
        <xsl:attribute name="href">
        <xsl:choose>
          <xsl:when test="not(contains(@href, '/')) and substring(@href, string-length(@href) - 3) = '.xml'">
            <xsl:value-of select="concat(substring(@href, 1, string-length(@href) - 4), '.html')"/>
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="@href"/>
          </xsl:otherwise>
        </xsl:choose>
        </xsl:attribute>
        <xsl:value-of select="@title"/>
        </xsl:element>
        </xsl:when>
        <xsl:otherwise>
        <xsl:value-of select="@title"/>
        </xsl:otherwise>
        </xsl:choose>
        </h4>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
    
    <xsl:template match="page:p">
        <p>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="page:a">
        <xsl:element name="a">
        <xsl:attribute name="href">
          <xsl:choose>
            <xsl:when test="not(contains(@href, '/')) and substring(@href, string-length(@href) - 3) = '.xml'">
              <xsl:value-of select="concat(substring(@href, 1, string-length(@href) - 4), '.html')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="@href"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:attribute>
        <xsl:if test="@title">
        <xsl:attribute name="title"><xsl:value-of select="@title"/></xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="page:b">
        <b><xsl:apply-templates/></b>
    </xsl:template>
    
    <xsl:template match="page:i">
        <i><xsl:apply-templates/></i>
    </xsl:template>
    
    <xsl:template match="page:tt">
        <code><xsl:apply-templates/></code>
    </xsl:template>

    <xsl:template match="page:codeblock">
        <xsl:element name="pre">
        <xsl:attribute name="name">code</xsl:attribute>
        <code>
        <xsl:apply-templates/>
        </code>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="page:img">
        <xsl:element name="div">
            <xsl:attribute name="style">text-align: center</xsl:attribute>
            <xsl:element name="img">
                <xsl:attribute name="src"><xsl:value-of select="@src"/></xsl:attribute>
                <xsl:attribute name="alt"><xsl:value-of select="@title"/></xsl:attribute>
            </xsl:element>
            <xsl:element name="br"/>
            <xsl:value-of select="@title"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="html:*">
        <xsl:element name="{local-name()}">
            <xsl:for-each select="@*">
                <xsl:attribute name="{name()}">
                    <xsl:value-of select="."/>
                </xsl:attribute>
            </xsl:for-each>
            <xsl:apply-templates select="node()"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>

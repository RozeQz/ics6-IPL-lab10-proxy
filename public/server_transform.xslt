<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">

<xsl:if test="output/input">
  <P>Вы ввели: <xsl:value-of select="output/input"/></P>
</xsl:if>
<xsl:choose>
<xsl:when test="output/error">
  <P class="text-danger">Ошибка: <xsl:value-of select="output/error"/></P>
</xsl:when>
<xsl:otherwise>
  <P>Ответ: <xsl:value-of select="output/result"/></P>
  <TABLE class="table table-striped">
      <TR>
          <TH scope="col">#</TH>
          <TH scope="col">Число</TH>
          <TH scope="col">Квадрат числа</TH>
      </TR>
      <xsl:for-each select="output/table/palindrome">
      <TR>
          <TD scope="row"><xsl:value-of select="output/table/palindrome/index"/></TD>
          <TD scope="row"><xsl:value-of select="output/table/palindrome/number"/></TD>
          <TD scope="row"><xsl:value-of select="output/table/palindrome/square"/></TD>
      </TR>
      </xsl:for-each>
  </TABLE><BR/>
</xsl:otherwise>
</xsl:choose>

</xsl:template>
</xsl:stylesheet>
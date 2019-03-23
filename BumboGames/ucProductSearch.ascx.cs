using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
/** Author: Greg VanKampen and Vaughn Rowse
 * Date:3-22-2019
 * File: ucProductSearch.cs
 **/
namespace BumboGames
{
    public partial class ucProductSearch : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        string[] removedSearchWords = { "the", "at", "a", "and", "or" };
        /// <summary>
        /// Sends a search query to the products page
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string queryString = $"{ QueryStringBuilder() }&all={this.chkAllWords.Checked}";
            Response.Redirect($"~/Products.aspx{queryString}");
        }
        /// <summary>
        /// builds a query string
        /// </summary>
        /// <returns></returns>
        private string QueryStringBuilder()
        {
            string queryStringBuild = "?";
            string[] filteredWords = FilteredSearchWords();

            //We only support 5 search words
            int counter = filteredWords.Count() > 5 ? 4 : filteredWords.Count() - 1;
            for (int i = 0; i <= counter; i++)
            {
                queryStringBuild += i == 0
                    ? $"word{i + 1}={filteredWords[i]}"
                    : $"&word{i + 1}={filteredWords[i]}";
            }

            return queryStringBuild;
        }
        /// <summary>
        /// remove ignored words
        /// </summary>
        /// <returns></returns>
        private string[] FilteredSearchWords()
        {
            string[] words = this.txtSearch.Text.Split(' ');
            List<string> cleanedWords = new List<string>();

            foreach (string word in words)
            {
                if (removedSearchWords.Where(w => w.ToLower() == word.ToLower()).Count() == 0)
                    cleanedWords.Add(word);
            }

            return cleanedWords.ToArray();
        }
    }
}
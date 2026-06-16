package db.migration;

import org.flywaydb.core.api.migration.BaseJavaMigration;
import org.flywaydb.core.api.migration.Context;

import java.sql.Statement;
import java.util.Locale;

public class V144__Admin_question_search_indexes extends BaseJavaMigration {
    @Override
    public void migrate(Context context) throws Exception {
        var productName = context.getConnection()
                .getMetaData()
                .getDatabaseProductName()
                .toLowerCase(Locale.ROOT);
        try (Statement statement = context.getConnection().createStatement()) {
            if (productName.contains("postgresql")) {
                statement.execute("CREATE EXTENSION IF NOT EXISTS pg_trgm");
                statement.execute("""
                        CREATE INDEX IF NOT EXISTS idx_questions_admin_filter
                        ON questions(status, review_status, difficulty, source, created_at DESC)
                        """);
                statement.execute("""
                        CREATE INDEX IF NOT EXISTS idx_questions_stem_trgm
                        ON questions USING gin (LOWER(stem) gin_trgm_ops)
                        """);
                statement.execute("""
                        CREATE INDEX IF NOT EXISTS idx_questions_explanation_trgm
                        ON questions USING gin (LOWER(explanation) gin_trgm_ops)
                        """);
                return;
            }
            statement.execute("""
                    CREATE INDEX IF NOT EXISTS idx_questions_admin_filter
                    ON questions(status, review_status, difficulty, source, created_at)
                    """);
        }
    }
}

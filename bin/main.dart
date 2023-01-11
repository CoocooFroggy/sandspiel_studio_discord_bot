import 'dart:io';

import 'package:nyxx/nyxx.dart';
import 'package:nyxx_commands/nyxx_commands.dart';
import 'package:sandspiel_studio_discord_bot/objects/ss_query.dart';
import 'package:sandspiel_studio_discord_bot/top_query.dart';

void main(List<String> arguments) {
  final bot = NyxxFactory.createNyxxWebsocket(
      Platform.environment['TOKEN']!, GatewayIntents.allUnprivileged)
    ..registerPlugin(Logging()) // Default logging plugin
    // ..registerPlugin(IgnoreExceptions()) // Plugin that handles uncaught exceptions that may occur
    ..registerPlugin(
        CliIntegration()); // Cli integration for nyxx allows stopping application via SIGTERM and SIGKILl

  CommandsPlugin commands = CommandsPlugin(
    prefix: (message) => '!',
    // Ignored below by SlashOnly

    // The `guild` parameter determines what guild slash commands will be registered to by default.
    //
    // This is useful for testing since registering slash commands globally can take up to an hour,
    // whereas registering commands for a single guild is instantaneous.
    //
    // If you aren't testing or want your commands to be registered globally, either omit this
    // parameter or set it to `null`.
    guild: Snowflake(Platform.environment['GUILD']!),

    options: CommandsOptions(
      logErrors: true,
      defaultCommandType: CommandType.slashOnly,
      autoAcknowledgeInteractions: true,
    ),
  );

  // Next, we add the commands plugin to our client:
  bot.registerPlugin(commands);

  // Finally, we tell the client to connect to Discord:
  bot.connect();

  ChatCommand topCommand = ChatCommand(
    'top',
    'Gets the top Sandspiel Studio posts in the past 30 days',
    (IChatContext context) async {
      if (context is IInteractionContext) {
        (context as IInteractionContext).acknowledge(hidden: false);
      }
      SSQuery top = await TopQuery.fetchTop();
      context.respond(MessageBuilder()..embeds = top.toEmbeds());
    },
  );

  commands.addCommand(topCommand);
}
